import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:ui';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // ---------------------------------------------------------------------------
  // NEON ARCHITECT THEME CONSTANTS
  // ---------------------------------------------------------------------------
  static const Color bg = Color(0xFF0E0E0F);
  static const Color surfaceLow = Color(0xFF131314);
  static const Color surfaceHigh = Color(0xFF262627);
  static const Color inputBg = Color(0xFF0D0D0E);
  static const Color primary = Color(0xFF73FFE3);
  static const Color primaryGlow = Color(0x3373FFE3); // 20% Alpha
  static const Color ghostBorder = Color(0x1AFFFFFF); // 10% Alpha

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // ⚠️ EmailJS credentials (kept verbatim as requested)
  final String serviceId = 'service_64avj6l';
  final String templateId = 'template_zric1n9';
  final String userId = 's5AX_1a5z8GO6hpLF';

  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  Future<void> sendEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'origin': 'https://ashwinn.netlify.app',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': nameController.text,
            'from_email': emailController.text,
            'message': messageController.text,
          }
        }),
      );

      if (response.statusCode == 200) {
        _showGreenSnackBar("Transmission Successful // Message delivered.");
        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Transmission failed. Re-verify quantum link.")),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network detached. Check physical connection.")),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _showGreenSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.spaceMono(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 950;
    final double paddingH = isMobile ? 24 : 80;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 100).copyWith(bottom: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            children: [
              // Main Layout Block
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLeftColumn(isMobile: true),
                        const SizedBox(height: 60),
                        _buildRightColumn(isMobile: true),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _buildLeftColumn(isMobile: false)),
                        const SizedBox(width: 80),
                        Expanded(flex: 7, child: _buildRightColumn(isMobile: false)),
                      ],
                    ),

              const SizedBox(height: 120),
              // Footer Interface
              _buildSiteFooter(isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LEFT COLUMN (Identity & Metrics)
  // ---------------------------------------------------------------------------
  Widget _buildLeftColumn({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "COMMUNICATION INTERFACE",
          style: GoogleFonts.spaceGrotesk(
            color: primary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 4.0,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: GoogleFonts.spaceGrotesk(
              fontSize: isMobile ? 56 : 72,
              fontWeight: FontWeight.bold,
              height: 1.0,
              letterSpacing: -2.0,
            ),
            children: [
              const TextSpan(text: "Let's ", style: TextStyle(color: Colors.white)),
              TextSpan(
                text: "Talk.",
                style: TextStyle(
                  color: primary,
                  shadows: [
                    Shadow(color: primary.withValues(alpha: 0.6), blurRadius: 30) // Deep Text Glow
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Architecting digital experiences through kinetic precision and high-end code. Reach out to discuss your next project.",
          style: GoogleFonts.inter(
            color: const Color(0xFFA0A0A0),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 48),

        // Glowing Core Image Container
        Container(
          width: isMobile ? double.infinity : 400,
          height: isMobile ? 400 : 480,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: primaryGlow,
                blurRadius: 80, // Massive deep ambient shadow matching the screenshot
                spreadRadius: -20,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              "assets/images/contactuss.png",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, __, ___) => Container(
                color: surfaceLow,
                child: const Icon(Icons.person, size: 100, color: Colors.white12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),

        // Contact Nodes
        _buildContactNode(Icons.location_on_rounded, "LOCATION", "Kannur, Kerala"),
        const SizedBox(height: 32),
        _buildContactNode(Icons.phone_rounded, "ENCRYPTED LINE", "+91 9747475105"),
        const SizedBox(height: 32),
        _buildContactNode(Icons.alternate_email_rounded, "DIGITAL MAIL", "ashwinaneesh11@gmail.com"),
      ],
    );
  }

  Widget _buildContactNode(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: surfaceLow,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primary, size: 20),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.spaceMono(
                color: const Color(0xFF6E6E73),
                fontSize: 10,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // RIGHT COLUMN (Transmission Data)
  // ---------------------------------------------------------------------------
  Widget _buildRightColumn({required bool isMobile}) {
    return Column(
      children: [
        // The Dark Form Block
        Container(
          padding: EdgeInsets.all(isMobile ? 32 : 48),
          decoration: BoxDecoration(
            color: surfaceLow,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Horizontal Inputs (Wrap on extreme mobile)
                if (isMobile) ...[
                  _buildNeonInput("SUBJECT NAME", "John Doe", nameController),
                  const SizedBox(height: 32),
                  _buildNeonInput("EMAIL PROTOCOL", "john@example.com", emailController, isEmail: true),
                ] else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildNeonInput("SUBJECT NAME", "John Doe", nameController),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: _buildNeonInput("EMAIL PROTOCOL", "john@example.com", emailController, isEmail: true),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),

                // Heavy Transmission Area
                _buildNeonInput("TRANSMISSION CONTENT", "Project details, timeline, or just a hi...",
                    messageController, maxLines: 6),
                const SizedBox(height: 48),

                // Bottom Form Action Row
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                     Wrap(
                      spacing: 16,
                      children: [
                        _buildGhostIconButton(FontAwesomeIcons.github, "https://github.com/Ashwinaneesh"),
                        _buildGhostIconButton(FontAwesomeIcons.linkedinIn, "https://www.linkedin.com/in/ashwin-aneesh-653526224"),
                        _buildGhostIconButton(FontAwesomeIcons.twitter, ""),
                      ],
                     ),
                    _buildSendButton(),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),

        // The Custom Vector Shape Map Placeholder mimicking the screenshot perfectly
        Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            color: const Color(0xFF161618), // Distinct dark map base
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Draw the giant faint location pin representing the map graphic
              Icon(
                Icons.location_on_rounded,
                size: 300,
                color: Colors.white.withValues(alpha: 0.03), // Faint vector shadow layer
              ),
              Icon(
                Icons.location_on_rounded,
                size: 200,
                color: Colors.white.withValues(alpha: 0.05), // Secondary vector drop
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNeonInput(String label, String hint, TextEditingController controller,
      {bool isEmail = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: primary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
          cursorColor: primary,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) return "DATA REQUIRED";
            if (isEmail) {
              final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!reg.hasMatch(value.trim())) return "INVALID PROTOCOL";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.2), fontSize: 15),
            filled: true,
            fillColor: inputBg,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            errorStyle: GoogleFonts.spaceMono(color: Colors.redAccent, fontSize: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: primary, width: 1.0), // Lights up the box strictly on focus
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGhostIconButton(IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (url.isNotEmpty) launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1C20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primary, size: 18),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: primaryGlow,
            blurRadius: 40,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: _isSending ? null : sendEmail,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            child: _isSending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                  )
                : Text(
                    "SEND MESSAGE",
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // KINETIC FOOTER
  // ---------------------------------------------------------------------------
  Widget _buildSiteFooter({required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: ghostBorder, width: 1.0)), // Minimal exact delimiter
      ),
      child: isMobile
          ? Column(
              children: [
                _buildFooterLinksRow(),
                const SizedBox(height: 24),
                _buildCopyRightText(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCopyRightText(),
                _buildFooterLinksRow(),
              ],
            ),
    );
  }

  Widget _buildCopyRightText() {
    return Text(
      "© 2024 NEON ARCHITECT. BUILT WITH KINETIC PRECISION.",
      style: GoogleFonts.spaceGrotesk(
        color: const Color(0xFF6E6E73),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildFooterLinksRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFooterLink("GITHUB", "https://github.com/Ashwinaneesh"),
        const SizedBox(width: 24),
        _buildFooterLink("LINKEDIN", "https://www.linkedin.com/in/ashwin-aneesh-653526224"),
        const SizedBox(width: 24),
        _buildFooterLink("CODEPEN", ""),
        const SizedBox(width: 24),
        _buildFooterLink("TWITTER", ""),
      ],
    );
  }

  Widget _buildFooterLink(String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (url.isNotEmpty) launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        },
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFFA0A0A0),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
