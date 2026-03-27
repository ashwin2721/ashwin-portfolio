import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'widgets/cyber_snake.dart';

class NavBar extends StatefulWidget {
  final Function(int) onNavItemSelected;

  const NavBar({super.key, required this.onNavItemSelected});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _showMenu = false;

  static const Color surfaceLow = Color(0xCC131314); // Slightly transparent
  static const Color primary = Color(0xFF73FFE3);
  static const Color ghostBorder = Color(0x1AFFFFFF); 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 900;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Container(
          width: isCompact ? double.infinity : 1100, // Floating Max width for desktop
          margin: EdgeInsets.symmetric(
            horizontal: isCompact ? 16 : 24, 
            vertical: 24
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: isCompact ? 24 : 20, vertical: 16),
                decoration: BoxDecoration(
                  color: surfaceLow,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: ghostBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ]
                ),
                child: isCompact
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _animatedTitleText(isMobile: true),
                              IconButton(
                                icon: Icon(
                                  _showMenu ? Icons.close : Icons.segment,
                                  color: primary,
                                ),
                                onPressed: toggleMenu,
                              ),
                            ],
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn,
                            height: _showMenu ? 310 : 0,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  navItem("00. THE_CORE", 0),
                                  navItem("01. ABOUT_ME", 1),
                                  navItem("02. SKILLSET", 2),
                                  navItem("03. ARCHIVES", 3),
                                  navItem("04. TERMINAL", 4),
                                  const SizedBox(height: 12),
                                  _buildArcadeButton(context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _animatedTitleText(isMobile: false),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                navItem("00. CORE", 0),
                                const SizedBox(width: 2),
                                navItem("01. ABOUT", 1),
                                const SizedBox(width: 2),
                                navItem("02. SKILLS", 2),
                                const SizedBox(width: 2),
                                navItem("03. WORK", 3),
                                const SizedBox(width: 2),
                                navItem("04. CONTACT", 4),
                                const SizedBox(width: 6),
                                // Arcade Game Button
                                _buildArcadeButton(context),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Arcade Game Trigger Button
  Widget _buildArcadeButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => showCyberSnakeGame(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF73FFE3).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF73FFE3).withValues(alpha: 0.35)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF73FFE3).withValues(alpha: 0.15),
                blurRadius: 12,
                spreadRadius: -2,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.gamepad_outlined, color: Color(0xFF73FFE3), size: 14),
              const SizedBox(width: 6),
              Text(
                'ARCADE',
                style: GoogleFonts.spaceMono(
                  color: const Color(0xFF73FFE3),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Neon Arch Logo
  Widget _animatedTitleText({required bool isMobile}) {
    return SizedBox(
      height: 24,
      child: DefaultTextStyle(
        style: GoogleFonts.spaceMono(
          fontSize: isMobile ? 12 : 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          isRepeatingAnimation: true,
          pause: const Duration(seconds: 4),
          animatedTexts: [
            TyperAnimatedText(
              "// ashwin.architect",
              speed: const Duration(milliseconds: 100),
            ),
            TyperAnimatedText(
              "// ashwin.dev",
              speed: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }

  // Clean Neon Item Hover
  Widget navItem(String title, int index) {
    return _HoverNavItem(
      title: title, 
      onTap: () {
        widget.onNavItemSelected(index);
        setState(() {
          _showMenu = false;
        });
      }
    );
  }
}

class _HoverNavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _HoverNavItem({required this.title, required this.onTap});

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF73FFE3).withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHovered ? const Color(0xFF73FFE3).withValues(alpha: 0.3) : Colors.transparent,
            )
          ),
          child: Text(
            widget.title,
            style: GoogleFonts.spaceMono(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: isHovered ? const Color(0xFF73FFE3) : const Color(0xFFA0A0A0),
            ),
          ),
        ),
      ),
    );
  }
}
