import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _textController;
  late AnimationController _skillsOffsetController;

  late Animation<Offset> _textSlide;
  late Animation<Offset> _skillsSlide;
  late Animation<double> _textFade;
  late Animation<double> _skillsFade;

  final List<_FloatingSkill> _skills = [];
  final List<String> skillTexts = [
    "Flutter", "Dart", "Firebase", "Riverpod", "MongoDB", "Express.js",
    "React", "Node.js", "JavaScript", "CouchDB", "Git", "GitHub",
    "REST API", "SQL", "HTML", "CSS", "FIREBASE", "JavaScript",
  ];

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _skillsOffsetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _skillsSlide = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _skillsOffsetController,
      curve: Curves.easeOut,
    ));

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _skillsFade = CurvedAnimation(
      parent: _skillsOffsetController,
      curve: Curves.easeIn,
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    final rand = Random();
    for (final skill in skillTexts) {
      _skills.add(_FloatingSkill(
        text: skill,
        dx: rand.nextDouble() * 200 - 100,
        dy: rand.nextDouble() * 200 - 100,
        angle: rand.nextDouble() * 2 * pi,
        radius: 60 + rand.nextDouble() * 100,
        speed: 0.4 + rand.nextDouble() * 0.8,
      ));
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _skillsOffsetController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (!_hasAnimated && info.visibleFraction > 0.3) {
          _textController.forward();
          _skillsOffsetController.forward();
          Future.delayed(const Duration(milliseconds: 200), () {
            _floatController.repeat();
          });
          setState(() {
            _hasAnimated = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTextSection(),
            const SizedBox(height: 40),
            _buildFloatingSkills(280, 14),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildTextSection()),
            const SizedBox(width: 40),
            Expanded(child: _buildFloatingSkills(400, 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return FadeTransition(
      opacity: _textFade,
      child: SlideTransition(
        position: _textSlide,
        child: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skills & Education",
                  style: GoogleFonts.orbitron(
                    color: const Color(0xFF26E0A6),
                    fontSize: 30,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "With a strong foundation in full-stack development, I specialize in building dynamic, responsive apps using Flutter and the MERN stack. I’ve worked extensively with Firebase, Git, REST APIs, CouchDB, and other modern development tools to create seamless user experiences.",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
                AnimatedOpacity(
                  opacity: _hasAnimated ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2EE9A0).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFF26E0A6), width: 1.2),
                    ),
                    child: Text(
                      "I hold a Bachelor of Technology degree in Computer Science from St. Thomas College of Engineering and Technology, Kannur.",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                        height: 1.6,
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

  Widget _buildFloatingSkills(double height, double fontSize) {
    return FadeTransition(
      opacity: _skillsFade,
      child: SlideTransition(
        position: _skillsSlide,
        child: SizedBox(
          height: height,
          child: AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: _skills.map((skill) {
                  final angle = skill.angle +
                      _floatController.value * 2 * pi * skill.speed;
                  final dx = cos(angle) * skill.radius;
                  final dy = sin(angle) * skill.radius;

                  return Transform.translate(
                    offset: Offset(dx, dy),
                    child: Text(
                      skill.text,
                      style: GoogleFonts.poppins(
                        fontSize: fontSize,
                        color: const Color(0xFF26E0A6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FloatingSkill {
  final String text;
  final double dx;
  final double dy;
  final double angle;
  final double radius;
  final double speed;

  _FloatingSkill({
    required this.text,
    required this.dx,
    required this.dy,
    required this.angle,
    required this.radius,
    required this.speed,
  });
}
