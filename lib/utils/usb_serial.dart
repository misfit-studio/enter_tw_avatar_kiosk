import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:linux_serial/linux_serial.dart';
import 'package:logging/logging.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:collection/collection.dart';

class UsbSerialService {
  static const serialDeviceVendorIds = [0x0403, 0x1A86];

  final log = Logger('UsbSerialService');

  static final UsbSerialService _singleton = UsbSerialService._internal();

  // Android Serial handles
  UsbDevice? _device;
  UsbPort? _port;

  // Linux Serial handles
  SerialPortHandle? _serialPortHandle;

  final StreamController<Uint8List> _serialDataStreamController =
      StreamController<Uint8List>.broadcast();

  factory UsbSerialService() {
    return _singleton;
  }

  UsbSerialService._internal();

  Stream<Uint8List> get serialDataStream => _serialDataStreamController.stream;

  Future<void> init() async {
    log.info("Initializing USB serial service");

    if (Platform.isAndroid) {
      UsbSerial.usbEventStream?.listen(_onAndroidUsbEvent);
      final device = await _findUsbDevice();
      if (device != null) {
        await _connectAndroid(device);
      }
    }

    if (Platform.isLinux) {
      _connectLinux();
    }
  }

  Future<void> dispose() async {
    log.info("Disposing USB serial service");

    await _disconnect();
    await _serialDataStreamController.close();
  }

  Future<void> write(Uint8List data) async {
    await _port?.write(data);
    await _serialPortHandle?.writeBytes(data);
  }

  Future<void> _onAndroidUsbEvent(UsbEvent event) async {
    switch (event.event) {
      case UsbEvent.ACTION_USB_ATTACHED:
        log.info("USB device attached: ${event.device}");
        if (event.device != null) {
          if (_device != null) await _disconnect();
          await _connectAndroid(event.device!);
        }
        break;
      case UsbEvent.ACTION_USB_DETACHED:
        log.info("USB device detached: ${event.device}");
        if (event.device != null) {
          if (_device == event.device) await _disconnect();
        }
        break;
    }
  }

  Future<UsbDevice?> _findUsbDevice() async {
    if (Platform.isAndroid) {
      List<UsbDevice> devices = await UsbSerial.listDevices();
      log.fine("Devices: $devices");

      final serialDevice = devices.firstWhereOrNull(
          (device) => serialDeviceVendorIds.contains(device.vid));
      if (serialDevice != null) {
        log.info("Serial device found: $serialDevice");
        return serialDevice;
      } else if (devices.isNotEmpty) {
        log.warning(
            "Serial device not found, trying first device: ${devices.first}");
        return devices.first;
      }
    }

    return null;
  }

  Future<bool> _connectAndroid(UsbDevice device) async {
    log.info("Connecting to device: $device");
    _device = device;

    try {
      _port = await _device!.create();
    } catch (e) {
      log.severe("Failed to connect to device: $_device", e);
      return false;
    }

    await _port!.setPortParameters(
      9600,
      UsbPort.DATABITS_8,
      UsbPort.STOPBITS_1,
      UsbPort.PARITY_NONE,
    );

    //await _port!.setDTR(true);
    //await _port!.setRTS(true);

    if (await (_port!.open()) != true) {
      log.severe("Failed to open port");
      return false;
    }

    log.info("Connected to device: $_device");

    //await _port?.write(Uint8List.fromList([0xFF]));

    _port?.inputStream?.listen((data) async {
      _serialDataStreamController.add(data);
    });

    return true;
  }

  Future<void> _connectLinux() async {
    /// get the list of available serial ports
    final ports = SerialPorts.ports;
    log.info("Available serial ports:");
    log.info(ports);

    /// find the serial port with the name `ttyS0`
    try {
      final port = ports.singleWhere((p) => p.name == 'ttyUSB0');

      /// open the port, so we can read and write things to it
      _serialPortHandle = port.open(baudrate: Baudrate.b57600);

      _serialPortHandle?.stream.listen((data) {
        _serialDataStreamController.add(Uint8List.fromList(data));
      });
    } catch (e) {
      log.severe("Failed to connect to serial device", e);
    }
  }

  Future<void> _disconnect() async {
    log.info("Disconnecting from device: $_device");

    await _port?.close();
    await _serialPortHandle?.close();
    _serialPortHandle = null;
    _port = null;
    _device = null;

    log.info("Disconnected from device: $_device");
  }
}
