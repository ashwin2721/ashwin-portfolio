import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;
    final double paddingH = isMobile ? 20 : 60;

    return Container(
      width: double.infinity,
      color: Colors.transparent, // Let ambient glow show through
      child: Stack(
        children: [
          // Subtly painted technical background grid!
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 80),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Segment
                    Text(
                      "SELECTED WORKS",
                      style: GoogleFonts.orbitron(
                        color: const Color(0xFF26E0A6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "ARCHITECTING",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: isMobile ? 48 : 64,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                        letterSpacing: -2,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF00B4DB), Color(0xFF26E0A6)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        "DIGITAL FRONTIERS.",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: isMobile ? 48 : 64,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 550),
                      child: Text(
                        "Exploring the intersection of kinetic precision and high-performance engineering. A collection of systems built with absolute focus on atmospheric depth and technical scalability.",
                        style: GoogleFonts.inter(
                          color: const Color(0xFFA0A0A0),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 64),

                    // The Masonry Project Grid
                    if (isMobile)
                      Column(
                        children: [
                          _buildCard1(),
                          const SizedBox(height: 24),
                          _buildCard2(),
                          const SizedBox(height: 24),
                          _buildCard3(),
                          const SizedBox(height: 24),
                          _buildCard4(isMobile: true),
                          const SizedBox(height: 24),
                          _buildCard5(isMobile: true), // YouTube Project
                        ],
                      )
                    else
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Column
                              Expanded(
                                flex: 10,
                                child: Column(
                                  children: [
                                    _buildCard1(),
                                    const SizedBox(height: 24),
                                    _buildCard3(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              // Right Column
                              Expanded(
                                flex: 9,
                                child: Column(
                                  children: [
                                    _buildCard2(),
                                    const SizedBox(height: 24),
                                    _buildCard4(isMobile: false),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _buildCard5(isMobile: false), // Spanning 5th Project
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CARD BUILDERS
  // ---------------------------------------------------------------------------

  Widget _buildCard1() {
    return _BaseProjectCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 380,
                // Instead of plain background, create the premium padding "mockup" look
                padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF383A4A), Color(0xFF232530)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/w3.png', // The real screenshot
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter, // Cuts the bottom cleanly off
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.web, size: 64, color: Colors.white24)),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                child: Row(
                  children: [
                    _buildTag("MERN STACK", const Color(0xFF1B3B30), const Color(0xFF4BD9B3)),
                    const SizedBox(width: 12),
                    _buildTag("FEATURED", const Color(0xFF272727), const Color(0xFF808080)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Stack E-Commerce Website",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "A high-performance retail engine featuring real-time inventory synchronization, dynamic filtering, and a seamless Stripe-integrated checkout experience.",
                        style: GoogleFonts.inter(
                          color: const Color(0xFFA0A0A0),
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                _buildCircularButton("https://ecommerce-mern-iicx.vercel.app/"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard2() {
    return _BaseProjectCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 480,
                // Heavy padding mapping the specific flutter isometric asset layout space
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B222E), Color(0xFF13151A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/w4.png',
                      // Changed from contain to cover to fake the 3D depth slice
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.phone_iphone, size: 80, color: Colors.white24)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                child: _buildTag("FLUTTER", const Color(0xFF143E4B), const Color(0xFF17AAB1)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Flutter Portfolio Website",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Immersive cross-platform showcase leveraging custom shader effects and fluid Rive animations for a premium user journey.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA0A0A0),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextLinkButton("EXPLORE PROJECT →", "https://ashwinn.netlify.app/"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard3() {
    return _BaseProjectCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  color: Color(0xFF192524),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/tool_management.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.handyman, size: 80, color: Colors.white24)),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                child: _buildTag("SYSTEM DESIGN", const Color(0xFF1A3832), const Color(0xFF57A38B)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tool Rental & Inventory",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Sophisticated logistics platform managing real-time equipment tracking and automated availability scheduling across multiple nodes.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA0A0A0),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard4({required bool isMobile}) {
    return _BaseProjectCard(
      child: IntrinsicHeight(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: isMobile ? double.infinity : 280,
              height: isMobile ? 240 : null,
              constraints: isMobile ? null : const BoxConstraints(minHeight: 280),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF0D181A),
                borderRadius: isMobile
                    ? const BorderRadius.vertical(top: Radius.circular(16))
                    : const BorderRadius.horizontal(left: Radius.circular(16)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/w1.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.api_outlined, size: 60, color: Colors.white24)),
                ),
              ),
            ),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "INFRASTRUCTURE",
                      style: GoogleFonts.orbitron(
                        color: const Color(0xFF00B4DB),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "User Management\nSystem API",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Secure, robust REST architecture featuring OAuth2 integration, JWT-based stateless authentication, and advanced role-based access control (RBAC).",
                      style: GoogleFonts.inter(
                        color: const Color(0xFFA0A0A0),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildMiniIcon(Icons.security),
                        const SizedBox(width: 12),
                        _buildMiniIcon(Icons.storage),
                        const SizedBox(width: 12),
                        _buildMiniIcon(Icons.route),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard5({required bool isMobile}) {
    // The previously omitted YouTube Clone - Reintegrated beautifully!
    return _BaseProjectCard(
      child: IntrinsicHeight(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "FRONTEND",
                          style: GoogleFonts.orbitron(
                            color: const Color(0xFFFF4B4B), // Youtube Red accent
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildTag("FEATURED", const Color(0xFF272727), const Color(0xFF808080)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "YouTube Clone",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "A fully-responsive YouTube replica engineered with pure HTML, CSS, and JS. Features intricate grid layouts, functional search components, and seamless interactive video hover mechanics.",
                      style: GoogleFonts.inter(
                        color: const Color(0xFFA0A0A0),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextLinkButton("EXPLORE PROJECT →", "", highlightColor: const Color(0xFFFF4B4B)),
                  ],
                ),
              ),
            ),
             Container(
              width: isMobile ? double.infinity : 550, // Massive image space right side
              height: isMobile ? 320 : null,
              padding: const EdgeInsets.only(top: 40, left: 40, bottom: 40, right: 0),
              decoration: BoxDecoration(
                color: const Color(0xFF141214), // Deep reddish-black backdrop
                borderRadius: isMobile
                    ? const BorderRadius.vertical(bottom: Radius.circular(16))
                    : const BorderRadius.horizontal(right: Radius.circular(16)),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
                   boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 20,
                      offset: Offset(-5, 5),
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/w2.png', // The YouTube Web screenshot
                    fit: BoxFit.cover,
                    alignment: Alignment.topLeft,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.video_library, size: 60, color: Colors.white24)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER COMPONENTS
  // ---------------------------------------------------------------------------

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildCircularButton(String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (url.isNotEmpty) {
            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFF6CF0CF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_outward,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildTextLinkButton(String text, String url, {Color highlightColor = const Color(0xFF6CF0CF)}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (url.isNotEmpty) {
            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          }
        },
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: highlightColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildMiniIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Icon(icon, color: const Color(0xFF7CF3D6), size: 16),
    );
  }
}

class _BaseProjectCard extends StatelessWidget {
  final Widget child;

  const _BaseProjectCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151515), // Deep dark grey card
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF262626), width: 1.5), // Subtle border outline
      ),
      child: child,
    );
  }
}

// Highly stylized technical background grid mimicking the user's screenshot
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..strokeWidth = 1;

    const double gridSize = 60.0;
    
    // Vertical grid lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // Horizontal grid lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
