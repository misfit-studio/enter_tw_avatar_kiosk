import 'dart:ui';

import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void initState() {
    super.initState();

    // Receive pointer events from the global GestureBinding.
    GestureBinding.instance.pointerRouter.addGlobalRoute((event) {
      // When the Pointer moves, normally, a PointerHoverEvent is dispatched.
      // TODO Check if we need to handle other events
      if (event is PointerHoverEvent) {
        setState(() {
          _pointerPosition = event.position;
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
