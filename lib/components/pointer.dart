import 'dart:ui';

import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:enter_bravo_kiosk/utils/serial_protocol.dart';
import 'package:enter_bravo_kiosk/utils/usb_serial.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class Pointer extends ConsumerStatefulWidget {
  const Pointer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PointerState();
}

class _PointerState extends ConsumerState<Pointer> {
  Offset _pointerPosition = const Offset(0, 0);

  @override
  void initState() {
    super.initState();

    GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
      if (event is PointerHoverEvent) {
        setState(() {
          _pointerPosition = event.position;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      ref.read(pointerDeviceStateNotifierProvider.notifier).setSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pointerState = ref.watch(pointerDeviceStateNotifierProvider);

    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (pointerState == PointerState.active)
          IgnorePointer(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 50),
                  left: _pointerPosition.dx - 10,
                  top: _pointerPosition.dy - 10,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}

// class Pointer extends ConsumerWidget {
//   const Pointer({
//     super.key,
//     this.child,
//   });

//   final Widget? child;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Stack(
//       children: [
//         if (child != null) child!,
//         // if (pointerState.state == PointerState.active)
//         ,
//       ],
//     );
//   }
// // }

class SerialPointer extends ConsumerStatefulWidget {
  final Widget? child;

  const SerialPointer({
    super.key,
    this.child,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SerialPointerState();
}

class _SerialPointerState extends ConsumerState<SerialPointer> {
  final log = Logger('SerialPointer');

  double _x = 0;
  double _y = 0;
  double _w = 0;
  double _h = 0;

  double _yaw = 0;
  double _pitch = 0;
  double _yawZero = 0;
  double _pitchZero = 0;

  bool _hasData = false;

  bool _btnAState = false;

  DateTime? _pointerDownTime;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      _w = size.width;
      _h = size.height;
      _x = size.width / 2;
      _y = size.height / 2;

      initController();
    });
  }

  void initController() async {
    final usbSerialService = UsbSerialService();

    final protocol = SerialProtocol(
      inStream: usbSerialService.serialDataStream,
      write: usbSerialService.write,
    );

    protocol.eventStream.listen((e) {
      Offset position = Offset(_x, _y);
      Offset delta = const Offset(0, 0);

      if (e is YprDataEvent) {
        //log.fine("P:${e.pitch} Y:${e.yaw}");
        _yaw = -(e.yaw + 180) % 360;
        _pitch = (e.pitch + 180) % 360;

        final yawDeltaRaw = _yaw - _yawZero;
        final yawDelta = yawDeltaRaw > 180
            ? yawDeltaRaw - 360
            : yawDeltaRaw < -180
                ? yawDeltaRaw + 360
                : yawDeltaRaw;

        final pitchDeltaRaw = _pitch - _pitchZero;
        final pitchDelta = pitchDeltaRaw > 180
            ? pitchDeltaRaw - 360
            : pitchDeltaRaw < -180
                ? pitchDeltaRaw + 360
                : pitchDeltaRaw;

        final absX = ((yawDelta + 30) / 60) * _w;
        final absY = ((pitchDelta + 30) / 60) * _h;
        final dx = absX - _x;
        final dy = absY - _y;
        position = Offset(absX, absY);
        delta = Offset(dx, dy);

        setState(() {
          _hasData = true;
          _x = absX;
          _y = absY;
        });
      }

      if (e is WasCalibratedEvent) {
        log.fine("Was calibrated");
        _yawZero = _yaw;
        _pitchZero = _pitch;
      }

      bool btnA = _btnAState;
      if (e is ButtonStateEvent) {
        btnA = e.buttonAPressed;
      }

      PointerEvent? pointerEvent;
      final timestamp = DateTime.timestamp();
      const kind = PointerDeviceKind.mouse;
      const device = 99;

      if (btnA != _btnAState) {
        _btnAState = btnA;
        if (btnA) {
          _pointerDownTime = timestamp;
          pointerEvent = PointerDownEvent(
            kind: kind,
            //timeStamp: Duration(milliseconds: pointerCounter++),
            device: device,
            position: position,
          );
        } else {
          _pointerDownTime = null;
          pointerEvent = PointerUpEvent(
            kind: kind,
            //timeStamp: Duration(milliseconds: pointerCounter++),
            device: device,
            position: position,
          );
        }
      } else {
        final timedelta = timestamp.difference(_pointerDownTime ?? timestamp);
        if (btnA &&
            timedelta.compareTo(const Duration(milliseconds: 250)) > 0) {
          // Start moving after timeout
          pointerEvent = PointerMoveEvent(
            kind: kind,
            timeStamp: timedelta,
            device: device,
            delta: delta,
          );
        } else if (!btnA) {
          pointerEvent = PointerHoverEvent(
            kind: kind,
            device: device,
            position: Offset(_x, _y),
          );
        }
      }
      if (pointerEvent != null) {
        GestureBinding.instance.handlePointerEvent(pointerEvent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (_hasData)
          IgnorePointer(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 50),
                  left: _x - 10,
                  top: _y - 10,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                  ),
                ),
                // Positioned(
                //   left: _x - 5,
                //   top: _y - 5,
                //   child: Container(
                //     width: 10,
                //     height: 10,
                //     decoration: const BoxDecoration(
                //       color: Colors.green,
                //       shape: BoxShape.circle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
      ],
    );
  }
}
