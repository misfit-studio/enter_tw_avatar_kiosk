import 'package:enter_bravo_kiosk/components/pointer.dart';
import 'package:enter_bravo_kiosk/state/router_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:enter_bravo_kiosk/utils/state_logger.dart';
import 'package:enter_bravo_kiosk/utils/usb_serial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:spine_flutter/spine_flutter.dart';

void main() async {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final log = Logger("main");

  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  log.info("Initializing application");

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

  await initSpineFlutter(enableMemoryDebugging: false);
  await UsbSerialService().init();

  runApp(ProviderScope(
    observers: [
      StateLogger(),
    ],
    child: const EnterBravoApp(),
  ));
}

class EnterBravoApp extends ConsumerWidget {
  const EnterBravoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: enterTheme,
        builder: (context, child) {
          return Pointer(
            child: child,
          );
        },
        routerConfig: router,
      ),
    );
  }
}
