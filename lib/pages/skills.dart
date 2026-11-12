import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;
    final double paddingH = isMobile ? 20 : 60;

    return Container(
      width: double.infinity,
      color: Colors.transparent, // Let ambient glow show through
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 80),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLeftColumn(context, isMobile: true),
                  const SizedBox(height: 60),
                  _buildRightColumn(context, isMobile: true),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildLeftColumn(context, isMobile: false),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: _buildRightColumn(context, isMobile: false),
                  ),
                ],
              ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LEFT COLUMN
  // ---------------------------------------------------------------------------
  Widget _buildLeftColumn(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 48 : 64,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: Colors.white,
              letterSpacing: -2,
            ),
            children: const [
              TextSpan(text: "EXPERTISE "),
              TextSpan(
                text: "&",
                style: TextStyle(color: Color(0xFF26E0A6)),
              ),
              TextSpan(text: "\nLOGIC"),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Paragraph
        Text(
          "Building efficient, scalable, and user-focused mobile applications with a strong emphasis on performance, clean architecture, and real-world usability.",
          style: GoogleFonts.inter(
            fontSize: isMobile ? 15 : 16,
            color: const Color(0xFFA0A0A0),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 48),

        // Row 1: Languages & Frameworks
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: _buildSkillCard(
                category: "01",
                title: "Programming",
                icon: Icons.code_rounded,
                chips: ["Dart", "JavaScript", "SQL", "HTML", "CSS"],
                isActive: true,
              ),
            ),
            SizedBox(width: 16, height: isMobile ? 16 : 0),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: _buildSkillCard(
                category: "02",
                title: "Frameworks",
                icon: Icons.layers_outlined,
                chips: ["Flutter", "React", "Node.js", "Express.js"],
                isActive: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 2: Databases & Design
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: _buildSkillCard(
                category: "03",
                title: "Databases & Tools",
                icon: Icons.storage_rounded,
                chips: ["Firebase", "MongoDB", "CouchDB", "Git", "Postman", "VS Code"],
                isActive: true,
              ),
            ),
            SizedBox(width: 16, height: isMobile ? 16 : 0),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: _buildSkillCard(
                category: "04",
                title: "Design & Prototyping",
                icon: Icons.brush_outlined,
                chips: ["Figma", "UI/UX", "Wireframing", "Prototyping"],
                isActive: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 3: State & Concepts
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: _buildSkillCard(
                category: "05",
                title: "State Management",
                icon: Icons.account_tree_outlined,
                chips: ["Cubit / Bloc", "Provider", "Riverpod"],
                isActive: true,
              ),
            ),
            SizedBox(width: 16, height: isMobile ? 16 : 0),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: _buildSkillCard(
                category: "06",
                title: "Core Concepts",
                icon: Icons.hub_outlined,
                chips: ["REST API", "Cross-Platform", "Responsive UI", "Agile", "Roadmaps"],
                isActive: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),

        // Academic Core Divider
        _buildDividerLabel("ACADEMIC CORE"),
        const SizedBox(height: 30),

        _buildTimelineCard(
          isMobile: isMobile,
          date: "CGPA: 7.07",
          title: "B.Tech in Computer Science\nand Engineering",
          gradeLabel: "Location",
          grade: "Kannur",
          icon: Icons.account_balance,
          institution: "St Thomas College of Engineering and Technology",
          subInstitution: "Kannur, Kerala",
        ),
        _buildTimelineCard(
          isMobile: isMobile,
          date: "86%",
          title: "Higher Secondary\nEducation (Biology Science)",
          gradeLabel: "Location",
          grade: "Kannur",
          icon: Icons.school_outlined,
          institution: "Munderi Government Higher Secondary School",
          subInstitution: "Kerala State Board",
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // RIGHT COLUMN (Experience)
  // ---------------------------------------------------------------------------
  Widget _buildRightColumn(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isMobile ? 0 : 150), // Align with Academic Core slightly
        _buildDividerLabel("EXPERIENCE CORE"),
        const SizedBox(height: 30),

        _buildTimelineCard(
          isMobile: isMobile,
          date: "PRESENT",
          title: "Product Manager",
          icon: Icons.assessment_outlined,
          institution: "Techtern Pvt. Ltd.",
          subInstitution: "Leading product-driven development, defining roadmaps, and cross-functional team management to scale mobile and web solutions efficiently.",
          isExperience: true,
        ),
        _buildTimelineCard(
          isMobile: isMobile,
          date: "PAST",
          title: "Flutter Developer",
          icon: Icons.work_outline,
          institution: "Techtern Pvt. Ltd.",
          subInstitution: "Architected high-performance cross-platform mobile apps with Flutter and Clean Architecture.",
          isExperience: true,
        ),
        _buildTimelineCard(
          isMobile: isMobile,
          date: "PAST",
          title: "MERN Stack Intern",
          icon: Icons.developer_mode,
          institution: "Zoople Technologies",
          subInstitution: "Engineering responsive full-stack web platforms using MongoDB, Express, React, and Node.js.",
          isExperience: true,
        ),
        const SizedBox(height: 80),
        _buildGraphicContainer(isMobile),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER COMPONENTS
  // ---------------------------------------------------------------------------

  Widget _buildDividerLabel(String text) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.1))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: GoogleFonts.orbitron(
              fontSize: 12,
              letterSpacing: 4,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFA0A0A0),
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.1))),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF161618), // Distinct dark grey typical for these cards
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF2A2A2C)), 
    );
  }

  Widget _buildSkillCard({
    required String category,
    required String title,
    required IconData icon,
    required List<String> chips,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: const Color(0xFF26E0A6), size: 24),
              Text(
                category,
                style: GoogleFonts.orbitron(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: const Color(0xFF6E6E73),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips.map((c) => _buildChip(c, isActive: isActive)).toList(),
          ),
        ],
      ),
    );
  }


  Widget _buildChip(String text, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF11302A) : const Color(0xFF212124),
        borderRadius: BorderRadius.circular(20), // Chips are rounded
        border: Border.all(color: isActive ? const Color(0xFF1B4D43) : const Color(0xFF333336)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isActive ? const Color(0xFF26E0A6) : const Color(0xFF909090),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimelineCard({
    required bool isMobile,
    required String date,
    required String title,
    String? gradeLabel,
    String? grade,
    required IconData icon,
    required String institution,
    String? subInstitution,
    bool isExperience = false, 
  }) {
    final Color mainColor = isExperience ? const Color(0xFF73FFE3) : const Color(0xFF26E0A6);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line and dot
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10), // Center with first line of title
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 180, // Generous height to ensure continuity
                color: Colors.white.withValues(alpha: 0.1),
              )
            ],
          ),
          const SizedBox(width: 20),
          // The Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: _cardDecoration(), // Glassmorphic look
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: GoogleFonts.orbitron(
                                color: mainColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              title,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (gradeLabel != null && grade != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              gradeLabel,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFA0A0A0),
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              grade,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                color: mainColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, color: mainColor, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              institution,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            if (subInstitution != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                subInstitution,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFFA0A0A0),
                                  height: 1.5,
                                ),
                              ),
                            ]
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphicContainer(bool isMobile) {
    final double boxSize = isMobile ? 320 : 400; // Adjusted size for column stacking

    return Center(
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, math.sin(_floatController.value * math.pi) * 8),
                child: child,
              );
            },
            child: SizedBox(
              width: boxSize,
              height: boxSize,
              child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Centered generated graphic
                Positioned.fill(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.loose(Size(boxSize * 0.9, boxSize * 0.9)),
                      child: Image.asset(
                        'assets/images/skills_orbit.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF26E0A6), width: 1),
                          ),
                          child: const Center(
                            child: Icon(Icons.blur_on, size: 80, color: Color(0xFF26E0A6)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Floating labels
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Positioned(
                      top: boxSize * 0.15 + (math.cos(_floatController.value * math.pi) * 6),
                      left: isMobile ? 0 : -20,
                      child: child ?? const SizedBox(),
                    );
                  },
                  child: _buildMetricLabel("SYSTEM: ACTIVE"),
                ),
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Positioned(
                      right: isMobile ? 0 : -30,
                      top: boxSize * 0.45 + (math.sin(_floatController.value * math.pi) * -6),
                      child: child ?? const SizedBox(),
                    );
                  },
                  child: _buildMetricLabel("MOBILE_APP_DEV"),
                ),
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Positioned(
                      bottom: boxSize * 0.25 + (math.cos(_floatController.value * math.pi) * -6),
                      right: boxSize * 0.1,
                      child: child ?? const SizedBox(),
                    );
                  },
                  child: _buildMetricLabel("CLEAN_SCALABLE"),
                ),
              ],
            ),
          ),
          ), // Close AnimatedBuilder

        ],
      ),
    );
  }

  Widget _buildMetricLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5), // Semi-transparent overlay
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF1E4038)), // Dark teal border
      ),
      child: Text(
        text,
        style: GoogleFonts.spaceMono(
          color: const Color(0xFF26E0A6),
          fontSize: 9,
        ),
      ),
    );
  }
}
