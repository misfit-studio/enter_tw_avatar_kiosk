import 'dart:async';
import 'dart:ui';

import 'package:enter_bravo_kiosk/state/serial_provider.dart';
import 'package:enter_bravo_kiosk/utils/serial_protocol.dart';
import 'package:flutter/gestures.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pointer_provider.g.dart';

final log = Logger("PointerProvider");

class PointerButtonState {
  final bool btnA;
  final bool btnB;

  const PointerButtonState({
    required this.btnA,
    required this.btnB,
  });

  @override
  String toString() => "PointerButtonState(btnA: $btnA, btnB: $btnB)";
}

enum PointerButtonEvent {
  pressed,
  released,
}

@Riverpod(keepAlive: true)
class PointerButtonStateNotifier extends _$PointerButtonStateNotifier {
  final StreamController<PointerButtonEvent> _eventController =
      StreamController.broadcast();

  bool _btnAState = false;
  bool _btnBState = false;

  void _listenToSerialProtocol() {
    final protocol = ref.watch(serialProtocolProvider);

    protocol.eventStream.listen((event) {
      if (event is PointerDeviceData) _handleDeviceData(event);
    });
  }

  void _handleDeviceData(PointerDeviceData data) {
    final newBtnAState = data.btnAPressed;
    final newBtnBState = data.btnBPressed;

    bool stateChanged = false;

    if (newBtnAState != _btnAState) {
      stateChanged = true;
      _btnAState = newBtnAState;
      _eventController.add(newBtnAState
          ? PointerButtonEvent.pressed
          : PointerButtonEvent.released);
    }

    if (newBtnBState != _btnBState) {
      stateChanged = true;
      _btnBState = newBtnBState;
      _eventController.add(newBtnBState
          ? PointerButtonEvent.pressed
          : PointerButtonEvent.released);
    }

    if (stateChanged) {
      state = PointerButtonState(btnA: _btnAState, btnB: _btnBState);
    }
  }

  @override
  PointerButtonState build() {
    _listenToSerialProtocol();
    return PointerButtonState(btnA: _btnAState, btnB: _btnBState);
  }

  Stream<PointerButtonEvent> get eventStream => _eventController.stream;
}

enum PointerState {
  idle,
  calibrating,
  active,
}

@Riverpod(
  keepAlive: true,
)
class PointerDeviceStateNotifier extends _$PointerDeviceStateNotifier {
  final _log = Logger("PointerDeviceStateNotifier");

  static const deviceKind = PointerDeviceKind.mouse;
  static const deviceId = 99;

  Size _size = Size.zero;
  Offset _delta = const Offset(0, 0);
  Offset _globalPosition = const Offset(0, 0);

  final double _xExtent = 10;
  final double _yExtent = 5 * 1.77;

  double _yaw = 0;
  double _pitch = 0;

  Timer? _calibrationTimeout;

  CalibrationStatus _calibrationStatus = CalibrationStatus.uncalibrated;
  StabilityStatus _stabilityStatus = StabilityStatus.unknown;

  bool _btnAState = false;
  bool _btnBState = false;

  DateTime? _pointerDownTime;
  DateTime? _pointerExitTime;
  Timer? _trackPointerTimer;

  void _listenToSerialProtocol() {
    final protocol = ref.watch(serialProtocolProvider);

    protocol.eventStream.listen((event) {
      if (event is PointerDeviceData) _handleDeviceData(event);
    });
  }

  void _startTrackingPointer() {
    _trackPointerTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // Check if global position is outside of screen
      if (_globalPosition.dx < 0 ||
          _globalPosition.dx > _size.width ||
          _globalPosition.dy < 0 ||
          _globalPosition.dy > _size.height) {
        // If outside for more than 5 seconds, change state to calibrating
        if (_pointerExitTime == null) {
          _pointerExitTime = DateTime.now();
        } else if (DateTime.now().difference(_pointerExitTime!) >
                const Duration(seconds: 6) &&
            state == PointerState.active) {
          log.info("Lost Pointer");
          state = PointerState.calibrating;
        }
      } else {
        _pointerExitTime = null;
      }
    });
  }

  void _handleDeviceData(PointerDeviceData data) {
    // Parse positional data
    final globalPosition = Offset(
      _size.width * (0.5 + ((data.yaw - 0.5) * _xExtent)),
      _size.height * (0.5 + ((data.pitch - 0.5) * _yExtent)),
    );

    _delta = globalPosition - _globalPosition;
    _globalPosition = globalPosition;

    // Parse stability status
    final stabilityStatus = data.stabilityStatus;
    if (stabilityStatus != _stabilityStatus) {
      _stabilityStatus = stabilityStatus;
      _handleStabilityChanged(_stabilityStatus);
    }

    _sendPointerEvents(newBtnAState: data.btnAPressed);
  }

  void _handleStabilityChanged(StabilityStatus status) {
    if (status == StabilityStatus.inMotion && state == PointerState.idle) {
      startCalibration();
    }
    if (status == StabilityStatus.hanging) {
      state = PointerState.idle;
    }
  }

  void _sendPointerEvents({bool? newBtnAState}) {
    if (state != PointerState.active) return;

    final timestamp = DateTime.timestamp();
    final btnState = newBtnAState ?? _btnAState;
    if (btnState != _btnAState) {
      // Button state changed
      _btnAState = btnState;
      if (btnState) {
        // Button pressed
        _pointerDownTime = timestamp;
        GestureBinding.instance.handlePointerEvent(PointerDownEvent(
          kind: deviceKind,
          device: deviceId,
          position: _globalPosition,
        ));
      } else {
        // Button released
        GestureBinding.instance.handlePointerEvent(PointerUpEvent(
          kind: deviceKind,
          device: deviceId,
          position: _globalPosition,
        ));
      }
    } else {
      // Button state unchanged
      final timedelta = timestamp.difference(_pointerDownTime ?? timestamp);
      if (btnState &&
          timedelta.compareTo(const Duration(milliseconds: 250)) > 0) {
        // Start moving after timeout
        GestureBinding.instance.handlePointerEvent(PointerMoveEvent(
          kind: deviceKind,
          device: deviceId,
          position: _globalPosition,
          delta: _delta,
        ));
      } else if (!btnState) {
        // Hover
        GestureBinding.instance.handlePointerEvent(PointerHoverEvent(
          kind: deviceKind,
          device: deviceId,
          position: _globalPosition,
        ));
      }
    }
  }

  @override
  PointerState build() {
    _listenToSerialProtocol();
    _startTrackingPointer();

    return PointerState.idle;
  }

  void setSize(Size size) {
    _log.fine("Setting size to $size");
    _size = size;
  }

  void startCalibration() {
    _log.fine("Starting calibration");
    state = PointerState.calibrating;
    _calibrationTimeout = Timer(const Duration(seconds: 30), () {
      _log.fine("Calibration timed out");
      state = PointerState.idle;
    });
  }

  Future<void> commitCalibration() async {
    final protocol = ref.read(serialProtocolProvider);
    await protocol.calibrate();

    _log.fine("Was calibrated");
    state = PointerState.active;
    _calibrationTimeout?.cancel();
    _sendPointerEvents();
  }
}
