import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/aboutus.dart';
import 'package:my_portfolio/pages/contactus.dart';
import 'package:my_portfolio/pages/home.dart';
import 'package:my_portfolio/pages/skills.dart';
import 'package:my_portfolio/pages/work.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:ui';
import './navbar.dart';
import './wrapper.dart'; // <-- Your custom cursor wrapper
import './ambient_glow_bg.dart';
import './widgets/bored_game_prompt.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ashwin',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child ?? const SizedBox(),
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

  void scrollTo(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const AmbientGlowBackground(),
          IgnorePointer(
            ignoring: true,
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ),
          Stack(
            children: [
              ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const SizedBox(height: 100);
                    case 1:
                      return HomeSection(
                        onViewProjectsPressed: _onViewProjectsPressed,
                      );
                    case 2:
                      return AboutSection(
                        onCollaborationPressed: _onCollaborationPressed,
                        onViewProjectsPressed: _onViewProjectsPressed,
                      );
                    case 3:
                      return const SkillsSection();
                    case 4:
                      return const WorkSection();
                    case 5:
                      return const ContactSection();
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NavBar(
                  onNavItemSelected: (index) => scrollTo(index + 1),
                ),
              ),
              const BoredGamePrompt(),
            ],
          ),
        ],
      ),
    );
  }

  void _onCollaborationPressed() {
    scrollTo(5);
  }

  void _onViewProjectsPressed() {
    scrollTo(4);
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
