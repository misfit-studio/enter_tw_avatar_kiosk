import 'dart:async';
import 'dart:typed_data';

import 'package:logging/logging.dart';

enum StabilityStatus {
  unknown,
  hanging,
  stable,
  inMotion,
}

enum CalibrationStatus {
  uncalibrated,
  calibrated,
}

String printBytes(Uint8List bytes) {
  return bytes.map((e) => "0x${e.toRadixString(16).padLeft(2, '0')}").join(' ');
}

String printUint16(int value) {
  final bytes = Uint8List(2);
  final view = ByteData.view(bytes.buffer);
  view.setUint16(0, value, Endian.big);
  return printBytes(bytes);
}

class SerialEvent {
  const SerialEvent(this.rawPacket);

  final SerialPacket rawPacket;

  @override
  String toString() {
    return 'SerialEvent{rawPacket: $rawPacket}';
  }
}

class YprDataEvent extends SerialEvent {
  YprDataEvent(this.yaw, this.pitch, this.roll, SerialPacket rawPacket)
      : super(rawPacket);

  final double yaw;
  final double pitch;
  final double roll;

  @override
  String toString() {
    return 'YprDataEvent{yaw: $yaw, pitch: $pitch, roll: $roll}';
  }
}

class PointerDeviceData extends SerialEvent {
  final double yaw;
  final double pitch;
  final StabilityStatus stabilityStatus;
  final CalibrationStatus calibrationStatus;
  final bool btnAPressed;
  final bool btnBPressed;

  const PointerDeviceData({
    required SerialPacket rawPacket,
    required this.yaw,
    required this.pitch,
    required this.stabilityStatus,
    required this.calibrationStatus,
    required this.btnAPressed,
    required this.btnBPressed,
  }) : super(rawPacket);
}

class ButtonStateEvent extends SerialEvent {
  ButtonStateEvent(
      this.buttonAPressed, this.buttonBPressed, SerialPacket rawPacket)
      : super(rawPacket);

  final bool buttonAPressed;
  final bool buttonBPressed;

  @override
  String toString() {
    return 'ButtonStateEvent{A: $buttonAPressed, B: $buttonBPressed}';
  }
}

class StabilityChangedEvent extends SerialEvent {
  StabilityChangedEvent(this.state, SerialPacket rawPacket) : super(rawPacket);

  final StabilityStatus state;

  @override
  String toString() {
    return 'StabilityChangedEvent{state: $state}';
  }
}

class WasCalibratedEvent extends SerialEvent {
  WasCalibratedEvent(SerialPacket rawPacket) : super(rawPacket);

  @override
  String toString() {
    return 'WasCalibratedEvent{}';
  }
}

class SerialPacket {
  static const int startSize = 2;
  static const int commandSize = 2;
  static const int crcSize = 2;

  static const int start = 0x5566;

  SerialPacket(this._command, this._data);

  final int _command;
  final Uint8List _data;
  int _crc = 0;

  int get command => _command;
  Uint8List get data => _data;

  @override
  String toString() {
    return 'SerialPacket{command: $command, bin: ${printBytes(serializeBinary())}, crc: ${getCrc().toRadixString(16)}';
  }

  static SerialPacket fromBinary(Uint8List data) {
    final view = ByteData.view(data.buffer);

    final start = view.getUint16(0, Endian.little);
    if (start != SerialPacket.start) {
      throw Exception('Invalid start sequence: ${printUint16(start)}');
    }

    final command = view.getUint16(2, Endian.little);
    final dataLength = data.length - startSize - commandSize - crcSize;
    final crc = view.getUint16(data.length - 2, Endian.little);

    final packet = SerialPacket(
        command,
        data.sublist(
            startSize + commandSize, startSize + commandSize + dataLength));
    final serialized = packet.serializeBinary();
    final calculatedCrc =
        _calculateCrc(serialized.sublist(0, serialized.length - crcSize));

    if (crc != calculatedCrc) {
      throw Exception(
          'Invalid CRC value: ${crc.toRadixString(16)} != ${calculatedCrc.toRadixString(16)}');
    }

    return packet;
  }

  Uint8List serializeBinary() {
    final dataLength = _data.length;
    final packetLength = startSize + commandSize + dataLength + crcSize;
    final packet = Uint8List(packetLength);
    final view = ByteData.view(packet.buffer);

    int offset = 0;
    view.setUint16(offset, start, Endian.little);
    offset += startSize;
    view.setUint16(offset, _command, Endian.little);
    offset += commandSize;
    packet.setRange(offset, offset + dataLength, _data);
    offset += dataLength;

    _crc =
        _calculateCrc(packet.sublist(0, startSize + commandSize + dataLength));
    view.setUint16(offset, _crc, Endian.little);

    return packet;
  }

  int getCrc() {
    if (_crc == 0) serializeBinary();
    return _crc;
  }

  /// Calculate CRC16-CCITT
  static int _calculateCrc(Uint8List data) {
    int crc = 0;
    for (int i = 0; i < data.length; i++) {
      crc ^= data[i] << 8;
      for (int j = 0; j < 8; j++) {
        if ((crc & 0x8000) != 0) {
          crc = (crc << 1) ^ 0x1021;
        } else {
          crc <<= 1;
        }
      }
    }
    return crc & 0xFFFF;
  }
}

class DeviceDataPacket extends SerialPacket {
  static const int deviceDataCommand = 0xAA01;

  DeviceDataPacket(
    this.yaw,
    this.pitch,
    this.stabilityStatus,
    this.calibrationStatus,
    this.btnAPressed,
    this.btnBPressed,
  ) : super(
          deviceDataCommand,
          _buildData(
            yaw,
            pitch,
            stabilityStatus,
            calibrationStatus,
            btnAPressed,
            btnBPressed,
          ),
        );

  final double yaw;
  final double pitch;
  final StabilityStatus stabilityStatus;
  final CalibrationStatus calibrationStatus;
  final bool btnAPressed;
  final bool btnBPressed;

  @override
  String toString() {
    return 'DeviceDataPacket{yaw: $yaw, pitch: $pitch, stabilityStatus: $stabilityStatus, calibrationStatus: $calibrationStatus, btnAPressed: $btnAPressed, btnBPressed: $btnBPressed}';
  }

  static Uint8List _buildData(
    double yaw,
    double pitch,
    StabilityStatus stabilityStatus,
    CalibrationStatus calibrationStatus,
    bool btnAPressed,
    bool btnBPressed,
  ) {
    final data = Uint8List(12);
    final view = ByteData.view(data.buffer);

    int offset = 0;
    view.setFloat32(offset, yaw, Endian.little);
    offset += 4;
    view.setFloat32(offset, pitch, Endian.little);
    offset += 4;
    view.setUint8(offset, stabilityStatus.index);
    offset += 1;
    view.setUint8(offset, calibrationStatus.index);
    offset += 1;
    view.setUint8(offset, btnAPressed ? 1 : 0);
    offset += 1;
    view.setUint8(offset, btnBPressed ? 1 : 0);

    return data;
  }

  static DeviceDataPacket fromPacket(SerialPacket packet) {
    final view = ByteData.view(packet.data.buffer);
    final yaw = view.getFloat32(0, Endian.little);
    final pitch = view.getFloat32(4, Endian.little);
    final stabilityStatus = StabilityStatus
        .values[view.getUint8(8) % StabilityStatus.values.length];
    final calibrationStatus = CalibrationStatus
        .values[view.getUint8(9) % CalibrationStatus.values.length];
    final btnAPressed = view.getUint8(10) == 1;
    final btnBPressed = view.getUint8(11) == 1;

    return DeviceDataPacket(
      yaw,
      pitch,
      stabilityStatus,
      calibrationStatus,
      btnAPressed,
      btnBPressed,
    );
  }
}

class CalibrateCommandPacket extends SerialPacket {
  static const int calibrateCommand = 0xFF02;

  CalibrateCommandPacket() : super(calibrateCommand, Uint8List(12));
}

class SerialProtocol {
  final log = Logger('SerialProtocol');

  static const int messageSize = 18;

  SerialProtocol({
    required this.inStream,
    required this.write,
  }) {
    start();
  }

  final Stream<Uint8List> inStream;
  final Future<void> Function(Uint8List) write;

  final _inBuffer = Uint8List(messageSize);
  late ByteData _inView;
  int _counter = 0;

  Timer? _dataTimeout;
  Timer? _resendTimer;
  Completer<void>? _commandCompleter;
  bool _hasSync = false;

  final _subscriptions = <StreamSubscription>[];

  final _eventStreamController = StreamController<SerialEvent>.broadcast();

  Stream<SerialEvent> get eventStream => _eventStreamController.stream;

  void start() {
    _subscriptions.addAll([
      inStream.listen(_dataReceived),
    ]);
    _inView = ByteData.view(_inBuffer.buffer);
  }

  void close() {
    _eventStreamController.close();
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
  }

  Future<void> calibrate() async {
    return _sendCommand(CalibrateCommandPacket());
  }

  Future<void> _sendCommand(SerialPacket packet) async {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) async {
        log.info('Resending packet: $packet');
        await write(packet.serializeBinary());
      },
    );

    _commandCompleter = Completer<void>();
    await _commandCompleter!.future;
    _commandCompleter = null;
  }

  void _dataReceived(Uint8List data) {
    //log.info('Received data: ${printBytes(data)}');
    for (var byte in data) {
      _processData(byte);
    }
    _dataTimeout?.cancel();
    _dataTimeout = Timer(const Duration(milliseconds: 500), _onDataTimeout);
  }

  void _processData(int byte) {
    //log.info('Processing byte: ${byte.toRadixString(16)}');

    if (!_hasSync) {
      if (byte == 0x66) {
        _hasSync = true;
        _counter = 0;
        log.fine('Obtained sync');
      } else {
        return;
      }
    }

    _counter++;
    _inView.setUint8(_counter - 1, byte);

    if (_counter >= messageSize) {
      _counter = 0;
      try {
        final packet = SerialPacket.fromBinary(_inBuffer);
        switch (packet.command) {
          case 0x0002:
            // ACK
            log.info('Received ACK');
            _resendTimer?.cancel();
            _commandCompleter?.complete();
            break;
          case DeviceDataPacket.deviceDataCommand:
            final event = DeviceDataPacket.fromPacket(packet);

            _eventStreamController.add(
              PointerDeviceData(
                rawPacket: packet,
                yaw: event.yaw,
                pitch: event.pitch,
                stabilityStatus: event.stabilityStatus,
                calibrationStatus: event.calibrationStatus,
                btnAPressed: event.btnAPressed,
                btnBPressed: event.btnBPressed,
              ),
            );
            break;
          default:
            log.warning('Unknown packet: $packet');
            break;
        }
      } catch (e, stackTrace) {
        log.warning('Error processing packet: $e', e, stackTrace);
        _hasSync = false;
      }
    }
  }

  void _onDataTimeout() {
    if (_counter > 0) {
      log.warning('Data timeout, resetting buffer');
      _counter = 0;
    }
  }
}
