import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/services.dart'; // for Clipboard
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WorkSection extends StatefulWidget {
  const WorkSection({super.key});

  @override
  State<WorkSection> createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> _projects = [
    {
      "title": "User Management System API",
      "image": "assets/images/w1.png",
      "description":
      "Backend API built with Node.js, Express.js, and MongoDB for managing users and products.\n\n• CRUD operations for users and products\n• MongoDB for secure, scalable data storage\n• Express.js for routing and middleware\n• Postman-tested REST endpoints for seamless API interaction",
      "link": ""
    },
    {
      "title": "YouTube Clone",
      "image": "assets/images/w2.png",
      "description":
      "A YouTube-inspired web app built using HTML, CSS, and JavaScript.\n\n• Dynamic video grid layout\n• Responsive UI for all screen sizes\n• Interactive search bar and sidebar\n• Smooth hover animations and dark theme design",
      "link": ""
    },
    {
      "title": "Full Stack E-Commerce Website",
      "image": "assets/images/w3.png",
      "description":
      "A complete MERN stack e-commerce platform with admin and user roles.\n\n• MongoDB, Express.js, React.js, Node.js\n• User authentication and role-based access\n• Persistent shopping cart and dynamic product management\n• Responsive design with optimized frontend and secure backend APIs",
      "video": "assets/images/ecom.mp4",
      "link": ""
    },
    {
      "title": "Flutter Portfolio Website",
      "image": "assets/images/w4.png",
      "description":
      "A modern, responsive personal portfolio website built entirely with Flutter Web.\n\n• Designed interactive sections like About, Skills, and Contact\n• Integrated smooth scroll navigation and custom animations\n• Used Responsive Framework for adaptive layout across devices\n• Showcased Flutter UI principles and clean, reusable widget structure",
      "link": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return VisibilityDetector(
      key: const Key('work-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : (isTablet ? 32 : 85),
          vertical: isMobile ? 48 : 64,
        ),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Projects",
              style: GoogleFonts.orbitron(
                fontSize: isMobile ? 23 : (isTablet ? 36 : 42),
                color: const Color(0xFF26E0A6),
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: isMobile ? 500 : 440,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _projects.length,
                separatorBuilder: (_, __) => const SizedBox(width: 24),
                itemBuilder: (context, index) {
                  return _AnimatedProjectCard(
                    project: _projects[index],
                    isMobile: isMobile,
                    index: index,
                    animate: _isVisible,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isMobile;
  final int index;
  final bool animate;

  const _AnimatedProjectCard({
    required this.project,
    required this.isMobile,
    required this.index,
    required this.animate,
  });

  @override
  State<_AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<_AnimatedProjectCard>
    with SingleTickerProviderStateMixin {
  double opacity = 0;
  double offsetX = -50;

  @override
  void initState() {
    super.initState();
    if (widget.animate) _startDelayedAnimation();
  }

  void _startDelayedAnimation() async {
    await Future.delayed(Duration(milliseconds: 260 * widget.index));
    if (mounted) {
      setState(() {
        opacity = 1;
        offsetX = 0;
      });
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedProjectCard oldWidget) {
    if (widget.animate && !oldWidget.animate) {
      _startDelayedAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 900),
      opacity: opacity,
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        transform: Matrix4.translationValues(offsetX, 0, 0),
        curve: Curves.easeOut,
        child: _ProjectCard(
          project: widget.project,
          isMobile: widget.isMobile,
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isMobile;

  const _ProjectCard({required this.project, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? 240 : 300,
      height: isMobile ? 100 : 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              project["image"],
              height: isMobile ? 140 : 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            project["title"],
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF26E0A6),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              project["description"],
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 12 : 13,
                height: 1.5,
                color: const Color(0xFFB0B0B0),
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (project["title"] == "Full Stack E-Commerce Website")
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          _VideoPopup(videoAsset: project["video"]),
                    );
                  },
                  icon: const Icon(Icons.play_circle_outline, size: 20),
                  label: const Text("Video Demo"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF26E0A6),
                    textStyle: TextStyle(fontSize: isMobile ? 12 : 13),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              IconButton(
                onPressed: () async {
                  final link = project["link"];
                  if (link != null && link.isNotEmpty) {
                    await Clipboard.setData(ClipboardData(text: link));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Link copied to clipboard!"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Color(0xFF26E0A6),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.copy, color: Color(0xFF26E0A6)),
                tooltip: "Copy Link",
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ---------------- Video Popup Widget -----------------
class _VideoPopup extends StatefulWidget {
  final String videoAsset;

  const _VideoPopup({required this.videoAsset});

  @override
  State<_VideoPopup> createState() => _VideoPopupState();
}

class _VideoPopupState extends State<_VideoPopup> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoAsset)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
          showControls: true,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black87,
      insetPadding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          if (_chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized)
            Container(
              width: double.infinity,
              height: 300,
              child: Chewie(controller: _chewieController!),
            )
          else
            const SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
