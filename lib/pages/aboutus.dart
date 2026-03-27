import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  /// The Neon Architect Color System
  static const Color bg = Color(0xFF0E0E0F);
  static const Color surfaceLow = Color(0xFF131314);
  static const Color surfaceHigh = Color(0xFF262627);
  static const Color primary = Color(0xFF73FFE3);
  static const Color secondary = Color(0xFF00CFFC);
  static const Color tertiary = Color(0xFF9BFFCE);
  static const Color ghostBorder = Color(0x26FFFFFF); // 15% White opacity ghosting

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;
    final double paddingH = isMobile ? 20 : 80;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: isMobile
              ? Column(
                  children: [
                    _buildLeftColumn(isMobile: true),
                    const SizedBox(height: 60),
                    _buildRightColumn(isMobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: _buildLeftColumn(isMobile: false)),
                    const SizedBox(width: 80),
                    Expanded(flex: 6, child: _buildRightColumn(isMobile: false)),
                  ],
                ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LEFT COLUMN (Visuals & Mechanics)
  // ---------------------------------------------------------------------------
  Widget _buildLeftColumn({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Photo Container with Overhanging Glass Card
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: isMobile ? 400 : 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.05),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  "assets/images/about.png",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: surfaceLow,
                    child: const Center(
                      child: Icon(Icons.person, size: 80, color: Colors.white24),
                    ),
                  ),
                ),
              ),
            ),

            // Anchored "Flutter Architect" Glass Floating Modal
            Positioned(
              bottom: -20,
              right: -20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: surfaceHigh.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ghostBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.code_rounded, color: primary, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Flutter Architect",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "BUILD :: DEPLOY :: SCALE",
                              style: GoogleFonts.spaceMono(
                                color: const Color(0xFFA0A0A0),
                                fontSize: 10,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),

        // Under-Image Code Segment (The Logic Console)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: surfaceLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.spaceMono(
                color: const Color(0xFFA0A0A0),
                fontSize: 12,
                height: 1.8,
              ),
              children: const [
                TextSpan(text: "class ", style: TextStyle(color: primary)),
                TextSpan(text: "NeonDeveloper ", style: TextStyle(color: secondary)),
                TextSpan(text: "{\n"),
                TextSpan(text: "  final ", style: TextStyle(color: primary)),
                TextSpan(text: "String mission = "),
                TextSpan(text: "\"Pixel-Perfect Efficiency\"", style: TextStyle(color: tertiary)),
                TextSpan(text: ";\n  "),
                TextSpan(text: "void ", style: TextStyle(color: primary)),
                TextSpan(text: "architect() {\n"),
                TextSpan(
                  text: "    // Designing high-performance cross-platform experiences\n",
                  style: TextStyle(color: Color(0xFF505055)),
                ),
                TextSpan(text: "    UI.render", style: TextStyle(color: secondary)),
                TextSpan(text: "(fluidity: "),
                TextSpan(text: "1.0", style: TextStyle(color: tertiary)),
                TextSpan(text: ", precision: "),
                TextSpan(text: "\"Absolute\"", style: TextStyle(color: tertiary)),
                TextSpan(text: ");\n  }\n}"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // RIGHT COLUMN (Narrative & Core Data)
  // ---------------------------------------------------------------------------
  Widget _buildRightColumn({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Tag
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 40, height: 1.5, color: primary),
            const SizedBox(width: 16),
            Text(
              "THE NARRATIVE",
              style: GoogleFonts.spaceGrotesk(
                color: primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 4.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Hero Typography
        Text(
          "Architecting",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: isMobile ? 48 : 64,
            fontWeight: FontWeight.bold,
            height: 1.0,
            letterSpacing: -1.5,
          ),
        ),
        Text(
          "Digital Velocity.",
          style: GoogleFonts.spaceGrotesk(
            color: primary,
            fontSize: isMobile ? 48 : 64,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -1.5,
            shadows: [
              Shadow(
                color: primary.withValues(alpha: 0.5),
                blurRadius: 30, // Atmospheric intense drop glow
                offset: const Offset(0, 0),
              )
            ],
          ),
        ),
        const SizedBox(height: 48),

        // Deep Narrative Solid Card (No Borders!)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
          decoration: BoxDecoration(
            color: surfaceLow, // Explicit structural transition through background color ONLY
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "I’m Ashwin, Flutter developer at Techtern Pvt. Ltd.",
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "I enjoy building responsive, user-friendly applications—whether it’s dynamic web platforms using MongoDB, Express.js, React, and Node.js, or crafting beautiful cross-platform apps with Flutter, Firebase, and Riverpod.\n\nCurrently, I bring ideas to life through clean, efficient, and scalable code. With a background in Computer Science and a hunger for growth, I stay continuously updated with the latest trends in modern architecture.",
                style: GoogleFonts.inter(
                  color: const Color(0xFFA0A0A0),
                  fontSize: 15,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 48),
              
              // Internal Card Statistics
              Wrap(
                spacing: 32,
                runSpacing: 24,
                children: [
                  _buildStatBlock("08+", "YEARS OF LOGIC"),
                  _buildStatBlock("250+", "PRODUCTS SHIPPED"),
                  _buildStatBlock("1.2k", "TTV PRECISION"),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 60),

        // Core Stack Module
        Text(
          "Core Stack",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildGlassChip("Flutter SDK"),
            _buildGlassChip("Dart Language"),
            _buildGlassChip("Clean Architecture"),
            _buildGlassChip("Firebase"),
            _buildGlassChip("Riverpod"),
            _buildGlassChip("CI/CD Mastery"),
            _buildGlassChip("React / Next.js"),
            _buildGlassChip("MERN DB"),
          ],
        ),
        const SizedBox(height: 60),

        // Action Buttons
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            _buildPrimaryGlowButton(),
            SizedBox(width: 24, height: isMobile ? 24 : 0),
            _buildOutlineGlassButton(),
          ],
        )
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // EXCLUSIVE NEON SYSTEM WIDGETS
  // ---------------------------------------------------------------------------

  Widget _buildStatBlock(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            color: secondary, // Using cyan-blue for stats
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.spaceMono(
            color: const Color(0xFF6E6E73),
            fontSize: 10,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: surfaceHigh.withValues(alpha: 0.5),
        border: Border.all(color: ghostBorder),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPrimaryGlowButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.3), // Massive deep primary glow
              blurRadius: 40,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Start Collaboration",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_outward, color: Colors.black, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineGlassButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          color: surfaceHigh.withValues(alpha: 0.2), // Barely visible glass background
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ghostBorder),
        ),
        child: Text(
          "View Prototypes",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
