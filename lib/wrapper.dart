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

          // Outer circle
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutQuad,
            left: _outerCursorTargetPosition.dx - 20,
            top: _outerCursorTargetPosition.dy - 20,
            child: IgnorePointer(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF26E0A6).withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Inner dot
          Positioned(
            left: _innerCursorPosition.dx - 4,
            top: _innerCursorPosition.dy - 4,
            child: IgnorePointer(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
