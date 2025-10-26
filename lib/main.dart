import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/aboutus.dart';
import 'package:my_portfolio/pages/contactus.dart';
import 'package:my_portfolio/pages/home.dart';
import 'package:my_portfolio/pages/skills.dart';
import 'package:my_portfolio/pages/work.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:video_player/video_player.dart';
import './navbar.dart';
import './wrapper.dart'; // <-- Your custom cursor wrapper

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        ],
      ),
      home: const CustomCursorWrapper(
        child: PortfolioHome(),
      ),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ItemScrollController _scrollController = ItemScrollController();
  late VideoPlayerController _videoController;

  void scrollTo(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/images/vid.mp4")
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoController.value.isInitialized
          ? Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
          // Fix: allow mouse events to pass through this layer
          IgnorePointer(
            ignoring: true,
            child: Container(
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          Column(
            children: [
              NavBar(onNavItemSelected: scrollTo),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const HomeSection();
                      case 1:
                        return const AboutSection();
                      case 2:
                        return const SkillsSection();
                      case 3:
                        return const WorkSection();
                      case 4:
                        return const ContactSection();
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
