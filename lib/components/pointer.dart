import 'dart:ui';

import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that renders the Pointer provided by the external pointing device.
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
  bool _pointerDown = false;

  @override
  void initState() {
    super.initState();

    // Receive pointer events from the global GestureBinding.
    GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
      if (!mounted) return;

      // When the Pointer moves, normally, a PointerHoverEvent is dispatched.
      // TODO Check if we need to handle other events
      if (event is PointerHoverEvent || event is PointerMoveEvent) {
        setState(() {
          _pointerPosition = event.position;
        });
      }
      if (event is PointerDownEvent) {
        setState(() {
          _pointerDown = true;
        });
      }
      if (event is PointerUpEvent) {
        setState(() {
          _pointerDown = false;
        });
      }
    });

    // The Pointer Controller needs to know the size of the window
    // This is the best place to report it
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      ref.read(pointerDeviceStateNotifierProvider.notifier).setSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pointerState = ref.watch(pointerDeviceStateNotifierProvider);

    final pointerSize = _pointerDown ? 40.sp : 48.sp;

    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (pointerState == PointerState.active)
          IgnorePointer(
            child: Stack(
              children: [
                // The Animated Widget gives the pointer some lag to smooth out the
                // movement
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 50),
                  left: _pointerPosition.dx - pointerSize / 2,
                  top: _pointerPosition.dy - pointerSize / 2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: pointerSize,
                    height: pointerSize,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: _pointerDown ? 6.sp : 4.sp,
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
