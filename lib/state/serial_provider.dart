import 'package:enter_bravo_kiosk/utils/serial_protocol.dart';
import 'package:enter_bravo_kiosk/utils/usb_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'serial_provider.g.dart';

@Riverpod(keepAlive: true)
SerialProtocol serialProtocol(SerialProtocolRef ref) {
  final usbSerialService = UsbSerialService();

  return SerialProtocol(
    inStream: usbSerialService.serialDataStream,
    write: usbSerialService.write,
  );
}
