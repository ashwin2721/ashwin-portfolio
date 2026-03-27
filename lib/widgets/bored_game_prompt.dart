import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cyber_snake.dart';

class BoredGamePrompt extends StatefulWidget {
  final Duration delay;
  const BoredGamePrompt({super.key, this.delay = const Duration(seconds: 5)});

  @override
  State<BoredGamePrompt> createState() => _BoredGamePromptState();
}

class _BoredGamePromptState extends State<BoredGamePrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer;
  bool _dismissed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0), // Slide in from right
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start timer to show the prompt
    _timer = Timer(widget.delay, () {
      if (mounted && !_dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    setState(() {
      _dismissed = true;
    });
    _controller.reverse();
  }

  void _playGame() {
    _dismiss();
    showCyberSnakeGame(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed && _controller.isDismissed) return const SizedBox.shrink();

    return Positioned(
      bottom: 30,
      right: 30,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: _playGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: _isHovered 
                          ? const Color(0xFF1A1F24) 
                          : const Color(0xCC131314),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _isHovered 
                            ? const Color(0xFF73FFE3).withValues(alpha: 0.6)
                            : const Color(0xFF73FFE3).withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        if (_isHovered)
                          BoxShadow(
                            color: const Color(0xFF73FFE3).withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        else
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF73FFE3).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.sports_esports_rounded,
                            color: Color(0xFF73FFE3),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Bored?",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "Let's play a game!",
                              style: GoogleFonts.spaceMono(
                                color: const Color(0xFFA0A0A0),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        // Close Button
                        GestureDetector(
                          onTap: _dismiss,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white54,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
