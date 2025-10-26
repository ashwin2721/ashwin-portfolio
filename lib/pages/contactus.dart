import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final String serviceId = 'service_64avj6l';
  final String templateId = 'template_zric1n9';
  final String userId = 's5AX_1a5z8GO6hpLF';

  final _formKey = GlobalKey<FormState>();

  Future<void> sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
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
      _showGreenSnackBar("Thank you! Message sent successfully");
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send message.")),
      );
    }
  }

  void _showGreenSnackBar(String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF26E0A6).withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      content: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.orbitron(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: isMobile ? 0 : 50,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: isMobile
                ? Column(
              children: [
                _buildFormSection(),
                const SizedBox(height: 40),
                _buildRightSection(),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildFormSection()),
                const SizedBox(width: 40),
                Expanded(child: _buildRightSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's talk",
            style: GoogleFonts.orbitron(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF26E0A6),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Have a thought, a question, or just feel like chatting?\nReach out — I’m always happy to connect!",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          _buildInput("Your Name", controller: nameController, validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Name is required";
            }
            return null;
          }),
          _buildInput("Your Email", controller: emailController, validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Email is required";
            }
            final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailReg.hasMatch(value.trim())) {
              return "Enter a valid email";
            }
            return null;
          }),
          _buildInput("Your Message", controller: messageController, maxLines: 4, validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Message cannot be empty";
            }
            return null;
          }),
          const SizedBox(height: 24),
          Container(
            width: 180,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF26E0A6),
            ),
            child: TextButton(
              onPressed: sendEmail,
              child: Text(
                "Send Message",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/contact.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Contact Info",
            style: GoogleFonts.orbitron(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF26E0A6),
            ),
          ),
          const SizedBox(height: 24),
          _buildContactRow(icon: Icons.location_on_outlined, text: "Kannur, Kerala\nIndia"),
          const SizedBox(height: 16),
          _buildContactRow(
            icon: Icons.phone,
            text: "+91 9747475105",
            onTap: () async {
              final Uri phoneUri = Uri(scheme: 'tel', path: '+919747475105');
              if (await canLaunchUrl(phoneUri)) {
                await launchUrl(phoneUri);
              }
            },
          ),
          const SizedBox(height: 16),
          _buildContactRow(
            icon: Icons.email_outlined,
            text: "ashwinaneesh11@gmail.com",
            onTap: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: 'ashwinaneesh11@gmail.com',
              );
              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              }
            },
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(FontAwesomeIcons.facebookF, 'https://www.facebook.com/share/1H4MdQCKRQ/'),
              const SizedBox(width: 20),
              _socialIcon(FontAwesomeIcons.twitter, 'https://x.com/Ashwink2721?t=1AYa5SqoS9uvo8Hk4ohYGA&s=09'),
              const SizedBox(width: 20),
              _socialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/ashwi__n_____?igsh=ZTR2emxuenhudg=='),
              const SizedBox(width: 20),
              _socialIcon(FontAwesomeIcons.whatsapp, 'https://wa.me/919747475105'),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      mouseCursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Could not open the link")),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF26E0A6).withOpacity(0.1),
            border: Border.all(color: const Color(0xFF26E0A6)),
          ),
          child: Icon(icon, color: const Color(0xFF26E0A6), size: 18),
        ),
      ),
    );
  }

  Widget _buildInput(
      String label, {
        required TextEditingController controller,
        int maxLines = 1,
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: GoogleFonts.poppins(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
