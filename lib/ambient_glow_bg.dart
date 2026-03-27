import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class AmbientGlowBackground extends StatefulWidget {
  const AmbientGlowBackground({super.key});

  @override
  State<AmbientGlowBackground> createState() => _AmbientGlowBackgroundState();
}

class _AmbientGlowBackgroundState extends State<AmbientGlowBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Solid dark base
        Container(color: const Color(0xFF090A0B)),
        
        // Animated Orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double val = _controller.value;
            final double sine = math.sin(val * math.pi * 2);
            final double cosine = math.cos(val * math.pi * 2);

            return Stack(
              children: [
                // Cyan Orb
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1 + (sine * 100),
                  left: MediaQuery.of(context).size.width * 0.1 + (cosine * 150),
                  child: _buildOrb(const Color(0xFF73FFE3), 400),
                ),
                // Blue Orb
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.2 - (cosine * 100),
                  right: MediaQuery.of(context).size.width * 0.1 + (sine * 150),
                  child: _buildOrb(const Color(0xFF00B4DB), 500),
                ),
                // Soft Purple/Green Orb
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4 + (cosine * 80),
                  left: MediaQuery.of(context).size.width * 0.5 - (sine * 120),
                  child: _buildOrb(const Color(0xFF1B4D43), 600),
                ),
              ],
            );
          },
        ),

        // Heavy Blur Filter to blend everything into an ambient gradient mesh
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120.0, sigmaY: 120.0),
          child: Container(
            color: Colors.transparent, // Required to apply the blur
          ),
        ),

        // Grid Overlay
        _buildCyberGrid(),
      ],
    );
  }

  Widget _buildOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: size / 2,
            spreadRadius: size / 4,
          ),
        ],
      ),
    );
  }

  Widget _buildCyberGrid() {
    return CustomPaint(
      size: Size.infinite,
      painter: GridPainter(),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03) // Very soft lines
      ..strokeWidth = 1.0;

    const double step = 60.0; // Grid square size
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
