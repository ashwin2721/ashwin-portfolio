import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  final String resumeUrl =
      'https://drive.google.com/uc?export=download&id=1UphB1TaTpuUdA01dsCkcqpeC8Imvd7VQ';

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void downloadResume() async {
    final url = Uri.parse(resumeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the resume link")),
      );
    }
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 700 &&
          MediaQuery.of(context).size.width < 1100;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = isMobile(context);
    final bool tablet = isTablet(context);

    // Adjust font sizes based on screen width
    final double titleFontSize = mobile
        ? 42
        : tablet
        ? 36
        : 44;

    final double descFontSize = mobile
        ? 17
        : tablet
        ? 20
        : 22;

    final double buttonPaddingV = mobile ? 12 : 16;
    final double buttonPaddingH = mobile ? 20 : 24;

    return Container(
      width: double.infinity,
      height: mobile ? size.height * 0.85 : size.height,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 16 : 20),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: mobile ? 100 : 180),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Animation
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'SOFTWARE DEVELOPER',
                      textStyle: GoogleFonts.orbitron(
                        color: const Color(0xFF26E0A6),
                        fontSize: titleFontSize,
                        letterSpacing: 2.7,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 120),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: Duration.zero,
                  displayFullTextOnTap: true,
                ),

                SizedBox(height: mobile ? 20 : 30),

                // Description Text
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      "Delivering modern, scalable web solutions with clean code\n"
                          "and responsive design — driven by a passion for crafting\n"
                          "impactful user experiences through thoughtful architecture.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: descFontSize,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFB0B0B0),
                        height: 1.6,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: mobile ? 30 : 50),

                // Download Resume Button
                Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(30),
                  shadowColor: const Color(0xFF26E0A6).withOpacity(0.5),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26E0A6),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: buttonPaddingH,
                        vertical: buttonPaddingV,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: downloadResume,
                    icon: const Icon(Icons.download, size: 20),
                    label: Text(
                      "Download Resume",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: mobile ? 14 : 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
