import 'package:flutter/material.dart';

class CustomCursorWrapper extends StatefulWidget {
  final Widget child;
  const CustomCursorWrapper({super.key, required this.child});

  @override
  State<CustomCursorWrapper> createState() => _CustomCursorWrapperState();
}

class _CustomCursorWrapperState extends State<CustomCursorWrapper> {
  Offset _innerCursorPosition = Offset.zero;
  Offset _outerCursorTargetPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      hitTestBehavior: HitTestBehavior.translucent,
      onHover: (event) {
        setState(() {
          _innerCursorPosition = event.localPosition;
          _outerCursorTargetPosition = event.localPosition;
        });
      },
      child: Stack(
        children: [
          widget.child,

          // Outer tech reticle
          AnimatedPositioned(
            duration: const Duration(milliseconds: 75),
            curve: Curves.easeOutCirc,
            left: _outerCursorTargetPosition.dx - 15,
            top: _outerCursorTargetPosition.dy - 15,
            child: IgnorePointer(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF26E0A6).withValues(alpha: 0.5), width: 1.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Container(width: 2, height: 2, color: const Color(0xFF26E0A6).withValues(alpha: 0.8)),
                ),
              ),
            ),
          ),

          // Inner precision core
          Positioned(
            left: _innerCursorPosition.dx - 3,
            top: _innerCursorPosition.dy - 3,
            child: IgnorePointer(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF73FFE3),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
