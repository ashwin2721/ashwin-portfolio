import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
    final isCompact = screenWidth < 800;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: isCompact
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _animatedTitleText(true),
                    IconButton(
                      icon: Icon(
                        _showMenu ? Icons.close : Icons.menu,
                        color: const Color(0xFF26E0A6),
                      ),
                      onPressed: toggleMenu,
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _showMenu ? 260 : 0,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navItem("Home", 0),
                        navItem("About", 1),
                        navItem("Skills", 2),
                        navItem("Works", 3),
                        navItem("Contact", 4),
                      ],
                    ),
                  ),
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _animatedTitleText(false),
                Wrap(
                  spacing: 24,
                  children: [
                    navItem("Home", 0),
                    navItem("About", 1),
                    navItem("Skills", 2),
                    navItem("Works", 3),
                    navItem("Contact", 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Title animation
  Widget _animatedTitleText(bool isMobile) {
    return SizedBox(
      height: 30,
      child: AnimatedTextKit(
        repeatForever: true,
        isRepeatingAnimation: true,
        pause: const Duration(seconds: 1),
        animatedTexts: [
          TyperAnimatedText(
            "Hey It's me Ashwin",
            textStyle: GoogleFonts.orbitron(
              fontSize: isMobile ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          ColorizeAnimatedText(
            "Hey It's me Ashwin",
            textStyle: GoogleFonts.orbitron(
              fontSize: isMobile ? 20 : 22,
              fontWeight: FontWeight.bold,
            ),
            colors: const [
              Color(0xFF26E0A6),
              Colors.white,
              Color(0xFF00FFFF),
              Colors.blue,
              Colors.cyan,
            ],
            speed: Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  // Reusable nav item
  Widget navItem(String title, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: TextButton(
          onPressed: () {
            widget.onNavItemSelected(index);
            setState(() {
              _showMenu = false;
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF26E0A6),
          ),
          child: Text(
            title,
            style: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              color: const Color(0xFF26E0A6),
            ),
          ),
        ),
      ),
    );
  }
}
