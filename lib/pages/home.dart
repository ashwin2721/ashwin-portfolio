import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with TickerProviderStateMixin {
  final String resumeUrl =
      'https://drive.google.com/uc?export=download&id=1WGZxQKAOk-kZTFChTUaN6lSqIbEt-A11';

  late AnimationController _controller;
  late AnimationController _floatController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
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
    _floatController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void downloadResume() async {
    final url = Uri.parse(resumeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the resume link")),
      );
    }
  }

  void viewProjects() {
    // You can hook this up to the itemScrollController via a callback
    // For now we will just show a quick snackbar or do nothing.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Scroll down to 'Works' section")),
    );
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = isMobile(context);

    // Dynamic padding and sizing
    final double paddingH = mobile ? 20 : 60;
    
    return Container(
      width: double.infinity,
      // Give enough height for stacking on mobile or full height on desktop
      height: mobile ? null : size.height,
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftColumn(mobile: true),
                    const SizedBox(height: 60),
                    _buildRightColumn(mobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _buildLeftColumn(mobile: false)),
                    const SizedBox(width: 40),
                    Expanded(flex: 5, child: _buildRightColumn(mobile: false)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn({required bool mobile}) {
    final double titleFontSize = mobile ? 48 : 72;
    final double descFontSize = mobile ? 16 : 18;
    
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26E0A6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF26E0A6).withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "SYSTEM STATUS: OPTIMIZED",
                    style: GoogleFonts.orbitron(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: const Color(0xFFB0B0B0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Bold Headers
            Text(
              "CRAFTING",
              style: GoogleFonts.poppins(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.0,
                letterSpacing: -1.5,
              ),
            ),
            // Gradient header
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF26E0A6), Color(0xFF00B4DB)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                "DIGITAL",
                style: GoogleFonts.poppins(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white, // Color is ignored by shader, but required
                  height: 1.0,
                  letterSpacing: -1.5,
                ),
              ),
            ),
            Text(
              "ARCHITECTURES",
              style: GoogleFonts.poppins(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.0,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Body Paragraph
            Text(
              "Engineering immersive digital ecosystems through high-performance software development, structural clean code, and fluidly responsive design systems that push the boundaries of the modern web.",
              style: GoogleFonts.openSans(
                fontSize: descFontSize,
                color: const Color(0xFFA0A0A0),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),

            // Buttons Row
            Wrap(
              spacing: 20,
              runSpacing: 16,
              children: [
                // Download Resume
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF26E0A6).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BFFD8), // Brighter mint
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: downloadResume,
                    icon: const Icon(Icons.download_rounded, size: 20),
                    label: Text(
                      "Download Resume",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // View Projects
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.15), width: 1.5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.02),
                  ),
                  onPressed: viewProjects,
                  child: Text(
                    "View Projects",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // Stats Bottom Row
            Row(
              mainAxisAlignment: mobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: [
                _buildStatItem("08+", "YEARS EXP", Colors.white, mobile),
                if (!mobile) const SizedBox(width: 40),
                _buildStatItem("250+", "DEPLOYMENTS", const Color(0xFF26E0A6), mobile),
                if (!mobile) const SizedBox(width: 40),
                _buildStatItem("1.2k", "COMMITS", const Color(0xFF00B4DB), mobile),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color valueColor, bool mobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: mobile ? 28 : 34,
            fontWeight: FontWeight.bold,
            color: valueColor,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.orbitron(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF808080),
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn({required bool mobile}) {
    final double boxWidth = mobile ? 320 : 440;
    final double boxHeight = mobile ? 320 : 420;
    
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            // Apply a delicate float logic to the entire container block
            return Transform.translate(
              offset: Offset(0, math.sin(_floatController.value * math.pi) * 8), // Gentle 8px float
              child: child,
            );
          },
          child: Center(
            child: SizedBox(
              width: boxWidth,
              height: boxHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
              // Back offset card
              Positioned.fill(
                top: 0,
                left: 0,
                bottom: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF161F20),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
                  ),
                ),
              ),
              // Main Abstract Box
              Positioned.fill(
                top: 15,
                left: 15,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF26332F)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 30,
                        offset: const Offset(-4, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/abstract_waves_bg.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFF1A1F24),
                        child: const Center(
                           child: Icon(Icons.waves, size: 60, color: Color(0xFF26E0A6))
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Top Right Floating Card (Mainframe)
              AnimatedBuilder(
                animation: _floatController,
                builder: (context, child) {
                  return Positioned(
                    top: -5 + (math.sin(_floatController.value * math.pi) * 8),
                    right: -20,
                    child: child ?? const SizedBox(),
                  );
                },
                child: _buildGlassCard(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF13453D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.terminal_rounded,
                          color: Color(0xFF7CF3D6),
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mainframe.exe",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Running scripts...",
                            style: GoogleFonts.spaceMono(
                              color: const Color(0xFF26E0A6),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Left Floating Card (Core Tech)
              AnimatedBuilder(
                animation: _floatController,
                builder: (context, child) {
                  return Positioned(
                    bottom: -15 + (math.cos(_floatController.value * math.pi) * 8),
                    left: -10,
                    child: child ?? const SizedBox(),
                  );
                },
                child: _buildGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "CORE TECH",
                        style: GoogleFonts.orbitron(
                          color: const Color(0xFFA0A0A0),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildTechChip("REACT", isActive: true),
                          const SizedBox(width: 8),
                          _buildTechChip("NODE.JS", isActive: false),
                          const SizedBox(width: 8),
                          _buildTechChip("AWS", isActive: false),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ));
}





  Widget _buildGlassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF14191A), // Matches screenshot dark base perfectly
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A3633)), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            offset: const Offset(0, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTechChip(String text, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0F362F) : const Color(0xFF26332F),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isActive ? const Color(0xFF26E0A6) : const Color(0xFF6E998F),
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
