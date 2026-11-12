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
                      "BUILDING",
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
                        "REAL-WORLD APPLICATIONS.",
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
                        "A collection of practical applications focused on performance, usability, and scalable architecture. Each project reflects my experience in Flutter, backend integration, and real-world problem solving.",
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
                          _buildToolsHubCard(),
                          const SizedBox(height: 24),
                          _buildCard1(),
                          const SizedBox(height: 24),
                          _buildCard3(),
                          const SizedBox(height: 24),
                          _buildCard2(),
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: [
                                _buildToolsHubCard(),
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
                                _buildCard1(),
                                const SizedBox(height: 24),
                                _buildCard2(),
                              ],
                            ),
                          ),
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

  Widget _buildToolsHubCard() {
    return _BaseProjectCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 380,
                padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2B2518), Color(0xFF161514)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/toolshub.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.shopping_cart, size: 64, color: Colors.white24)),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTag("FLUTTER & NODE.JS", const Color(0xFF332912), const Color(0xFFFFB800)),
                    _buildTag("GEMINI AI", const Color(0xFF14303B), const Color(0xFF00D2FF)),
                    _buildTag("FEATURED", const Color(0xFF272727), const Color(0xFF808080)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "ToolsHub — Enterprise E-Commerce & Hardware Marketplace",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildCircularButton("https://tooolshub.netlify.app/"),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "A full-stack, cross-platform hardware e-commerce platform built with Flutter, Riverpod, PostgreSQL, and Node.js—featuring Google Gemini AI shopping assistance and real-time geo-fenced delivery pricing.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA0A0A0),
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "ToolsHub is an enterprise-grade, cross-platform e-commerce solution engineered for heavy-duty power tools, industrial hardware, and tool maintenance services. Built with a responsive Flutter (Mobile & Web) client and a companion Node.js/TypeScript REST API with PostgreSQL, the application integrates real-time product discovery, distance-based dynamic shipping calculations via OpenStreetMap, integrated digital payments (Razorpay/UPI/Cards), and an AI-driven shopping assistant powered by Google Gemini.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA0A0A0),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextLinkButton("EXPLORE TOOLSHUB LIVE →", "https://tooolshub.netlify.app/", highlightColor: const Color(0xFFFFB800)),
              ],
            ),
          )
        ],
      ),
    );
  }

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
                    _buildTag("FULL STACK PROJECT", const Color(0xFF1B3B30), const Color(0xFF4BD9B3)),
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
                        "E-Commerce Web Application",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "A full-stack e-commerce platform with admin dashboard and product management features. Implemented secure authentication, REST APIs, and dynamic data handling for scalable and efficient operations.",
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
                child: _buildTag("FLUTTER PROJECT", const Color(0xFF143E4B), const Color(0xFF17AAB1)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Portfolio Website",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "A responsive portfolio website designed to showcase projects and skills with smooth navigation, animations, and clean UI for an enhanced user experience.",
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
                child: _buildTag("FLUTTER PROJECT", const Color(0xFF1A3832), const Color(0xFF57A38B)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tools Rental & Inventory Management System",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "A multi-tenant, enterprise-grade mobile & local-first solution for power tool rental businesses, featuring real-time inventory tracking, automated billing, and ledger management.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA0A0A0),
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "A cross-platform tool rental and inventory management system engineered with Flutter, Riverpod, and a multi-tenant CouchDB / Cloud Firestore backend. Designed to streamline shop floor operations for tool rental businesses, the application handles end-to-end rental lifecycles—from barcode-assisted dispatch and custom pricing logic to partial payment tracking, digital invoicing, and analytical reporting.",
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
