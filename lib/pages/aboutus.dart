import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _startAnimation() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 700 &&
          MediaQuery.of(context).size.width < 1100;

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobile(context);

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.3) {
          _startAnimation();
        }
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 16 : 24,
              vertical: mobile ? 32 : 48,
            ),
            color: Colors.transparent,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: mobile
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(isTablet(context)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ----------- MOBILE LAYOUT -----------
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildImage(width: double.infinity, height: 500),
        const SizedBox(height: 24),
        _buildTextContent(),
      ],
    );
  }

  /// ----------- DESKTOP / TABLET LAYOUT -----------
  Widget _buildDesktopLayout(bool tablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: tablet ? 1 : 1,
          child: _buildImage(width: tablet ? 280 : 350, height: 400),
        ),
        const SizedBox(width: 40),
        Flexible(
          flex: 3,
          child: SizedBox(
            width: tablet ? 600 : 900,
            height: 400,
            child: _buildTextContent(),
          ),
        ),
      ],
    );
  }

  /// IMAGE
  Widget _buildImage({double? width, double? height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        "assets/images/about.png",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  /// TEXT CONTENT
  Widget _buildTextContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ABOUT ME",
            style: GoogleFonts.orbitron(
              color: const Color(0xFF26E0A6),
              fontSize: 20,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "I’m Ashwin, Flutter developer at Techtern Pvt. Ltd.",
            style: GoogleFonts.poppins(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "I’m a passionate developer with a deep interest in web development, backed by hands-on experience in both the MERN stack and Flutter. "
                "I enjoy building responsive, user-friendly applications—whether it’s dynamic web platforms using MongoDB, Express.js, React, and Node.js, "
                "or crafting beautiful cross-platform apps with Flutter, Firebase, and Riverpod.\n\n"
                "Currently, I work as a Flutter developer at Techtern Pvt. Ltd., where I bring ideas to life through clean, efficient, and scalable code. "
                "With a background in Computer Science and a hunger for growth, I stay continuously updated with the latest trends in modern development.",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFFB0B0B0),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
