import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
// ENTRY POINT: Overlay launcher
// ─────────────────────────────────────────────
void showCyberSnakeGame(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.85),
    barrierDismissible: false,
    builder: (_) => const CyberSnakeOverlay(),
  );
}

// ─────────────────────────────────────────────
// OVERLAY SHELL
// ─────────────────────────────────────────────
class CyberSnakeOverlay extends StatelessWidget {
  const CyberSnakeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;
    
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile ? size.width * 0.95 : 560,
          height: isMobile ? size.height * 0.9 : 720,
          decoration: BoxDecoration(
            color: const Color(0xFF080A0B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF26E0A6).withValues(alpha: 0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF26E0A6).withValues(alpha: 0.15),
                blurRadius: 60,
                spreadRadius: -10,
              )
            ],
          ),
          child: Column(
            children: [
              _buildTitleBar(context),
              const Expanded(child: CyberSnakeGame()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color(0xFF26E0A6).withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: Color(0xFF26E0A6), shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'MAINFRAME_TERMINAL :: CYBER_SNAKE.exe',
              style: GoogleFonts.spaceMono(
                color: const Color(0xFF26E0A6),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: const Icon(Icons.close, color: Colors.white54, size: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GAME CONSTANTS
// ─────────────────────────────────────────────
const int _kGridSize = 20; // 20x20 cells
const Duration _kTickDuration = Duration(milliseconds: 140);

enum _Direction { up, down, left, right }

// ─────────────────────────────────────────────
// GAME ENGINE WIDGET
// ─────────────────────────────────────────────
class CyberSnakeGame extends StatefulWidget {
  const CyberSnakeGame({super.key});

  @override
  State<CyberSnakeGame> createState() => _CyberSnakeGameState();
}

class _CyberSnakeGameState extends State<CyberSnakeGame> with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  Timer? _ticker;

  List<Point<int>> _snake = [];
  Point<int> _food = const Point(10, 5);
  _Direction _direction = _Direction.right;
  _Direction _nextDirection = _Direction.right;
  int _score = 0;
  int _highScore = 0;
  bool _gameOver = false;
  bool _started = false;

  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))
      ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.3, end: 1.0).animate(_glowController);
    _resetGame();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _focusNode.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _resetGame() {
    _ticker?.cancel();
    setState(() {
      _snake = [
        const Point(10, 10),
        const Point(9, 10),
        const Point(8, 10),
      ];
      _direction = _Direction.right;
      _nextDirection = _Direction.right;
      _score = 0;
      _gameOver = false;
      _started = false;
      _food = _randomFood();
    });
  }

  void _startGame() {
    _started = true;
    _ticker = Timer.periodic(_kTickDuration, (_) => _tick());
  }

  Point<int> _randomFood() {
    final rng = Random();
    Point<int> pos;
    do {
      pos = Point(rng.nextInt(_kGridSize), rng.nextInt(_kGridSize));
    } while (_snake.contains(pos));
    return pos;
  }

  void _tick() {
    if (!mounted) return;
    setState(() {
      _direction = _nextDirection;
      final head = _snake.first;

      Point<int> newHead;
      switch (_direction) {
        case _Direction.up:    newHead = Point(head.x, head.y - 1); break;
        case _Direction.down:  newHead = Point(head.x, head.y + 1); break;
        case _Direction.left:  newHead = Point(head.x - 1, head.y); break;
        case _Direction.right: newHead = Point(head.x + 1, head.y); break;
      }

      // Wall collision
      if (newHead.x < 0 || newHead.x >= _kGridSize || newHead.y < 0 || newHead.y >= _kGridSize) {
        _endGame();
        return;
      }
      // Self collision (exclude tail because it will move)
      if (_snake.sublist(0, _snake.length - 1).contains(newHead)) {
        _endGame();
        return;
      }

      _snake.insert(0, newHead);

      if (newHead == _food) {
        _score++;
        _food = _randomFood();
      } else {
        _snake.removeLast();
      }
    });
  }

  void _endGame() {
    _ticker?.cancel();
    _gameOver = true;
    if (_score > _highScore) _highScore = _score;
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        _changeDirection(_Direction.up);
        break;
      case LogicalKeyboardKey.arrowDown:
        _changeDirection(_Direction.down);
        break;
      case LogicalKeyboardKey.arrowLeft:
        _changeDirection(_Direction.left);
        break;
      case LogicalKeyboardKey.arrowRight:
        _changeDirection(_Direction.right);
        break;
    }
  }

  void _changeDirection(_Direction newDir) {
    if (!_started && !_gameOver) {
      _startGame();
    } else if (_gameOver) {
      _resetGame();
      Future.delayed(const Duration(milliseconds: 100), _startGame);
      return;
    }

    switch (newDir) {
      case _Direction.up:
        if (_direction != _Direction.down) _nextDirection = _Direction.up;
        break;
      case _Direction.down:
        if (_direction != _Direction.up) _nextDirection = _Direction.down;
        break;
      case _Direction.left:
        if (_direction != _Direction.right) _nextDirection = _Direction.left;
        break;
      case _Direction.right:
        if (_direction != _Direction.left) _nextDirection = _Direction.right;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 600;

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKey,
      child: GestureDetector(
        onTap: () {
          if (!_started && !_gameOver) {
            _startGame();
          } else if (_gameOver) {
            _resetGame();
            Future.delayed(const Duration(milliseconds: 100), _startGame);
          }
          _focusNode.requestFocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHUD(),
              const SizedBox(height: 12),
              Expanded(child: _buildGrid()),
              const SizedBox(height: 12),
              if (isCompact) ...[
                _buildDPad(),
                const SizedBox(height: 12),
              ],
              _buildControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDPad() {
    return Column(
      children: [
        _buildPadButton(Icons.keyboard_arrow_up, _Direction.up),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPadButton(Icons.keyboard_arrow_left, _Direction.left),
            const SizedBox(width: 40),
            _buildPadButton(Icons.keyboard_arrow_right, _Direction.right),
          ],
        ),
        _buildPadButton(Icons.keyboard_arrow_down, _Direction.down),
      ],
    );
  }

  Widget _buildPadButton(IconData icon, _Direction dir) {
    return GestureDetector(
      onTap: () => _changeDirection(dir),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: const Color(0xFF73FFE3).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF26E0A6).withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: const Color(0xFF73FFE3), size: 30),
      ),
    );
  }

  Widget _buildHUD() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHudBlock('SCORE', '$_score'),
        _buildHudBlock('HIGH_SCORE', '$_highScore'),
        _buildHudBlock('LENGTH', '${_snake.length}'),
      ],
    );
  }

  Widget _buildHudBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.spaceMono(
          color: const Color(0xFF666666),
          fontSize: 9,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
        )),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.orbitron(
          color: const Color(0xFF26E0A6),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
      ],
    );
  }

  Widget _buildGrid() {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: _glowAnim,
        builder: (context, _) {
          return CustomPaint(
            painter: _SnakeGridPainter(
              snake: _snake,
              food: _food,
              gridSize: _kGridSize,
              glowOpacity: _glowAnim.value,
              gameOver: _gameOver,
            ),
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    if (!_started && !_gameOver) {
      return Column(children: [
        Text('[ CLICK OR PRESS ANY ARROW KEY TO START ]',
          style: GoogleFonts.spaceMono(color: const Color(0xFF26E0A6).withValues(alpha: 0.7), fontSize: 10, letterSpacing: 1)),
      ]);
    }
    if (_gameOver) {
      return Column(children: [
        Text('TRANSMISSION TERMINATED', style: GoogleFonts.orbitron(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 6),
        Text('[ CLICK OR PRESS ANY KEY TO RECONNECT ]', style: GoogleFonts.spaceMono(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
      ]);
    }
    return Text('USE ARROW KEYS TO NAVIGATE THE DATA STREAM',
      style: GoogleFonts.spaceMono(color: Colors.white24, fontSize: 9, letterSpacing: 1));
  }
}

// ─────────────────────────────────────────────
// CUSTOM PAINTER FOR THE GRID
// ─────────────────────────────────────────────
class _SnakeGridPainter extends CustomPainter {
  final List<Point<int>> snake;
  final Point<int> food;
  final int gridSize;
  final double glowOpacity;
  final bool gameOver;

  const _SnakeGridPainter({
    required this.snake,
    required this.food,
    required this.gridSize,
    required this.glowOpacity,
    required this.gameOver,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / gridSize;
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw grid lines
    for (int i = 0; i <= gridSize; i++) {
      canvas.drawLine(Offset(i * cellSize, 0), Offset(i * cellSize, size.height), gridPaint);
      canvas.drawLine(Offset(0, i * cellSize), Offset(size.width, i * cellSize), gridPaint);
    }

    // Draw border
    final borderPaint = Paint()
      ..color = const Color(0xFF26E0A6).withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8)),
      borderPaint,
    );

    // Draw food (glowing data node)
    final foodColor = gameOver ? Colors.red.withValues(alpha: glowOpacity) : const Color(0xFFFF6B4A);
    final foodGlowPaint = Paint()
      ..color = foodColor.withValues(alpha: 0.3 * glowOpacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    final foodR = Rect.fromCenter(
      center: Offset(food.x * cellSize + cellSize / 2, food.y * cellSize + cellSize / 2),
      width: cellSize * 0.72,
      height: cellSize * 0.72,
    );
    canvas.drawOval(foodR.inflate(4), foodGlowPaint);

    final foodPaint = Paint()..color = foodColor;
    canvas.drawOval(foodR, foodPaint);

    // Draw snake segments
    for (int i = 0; i < snake.length; i++) {
      final seg = snake[i];
      final isHead = i == 0;
      final ratio = 1 - (i / snake.length) * 0.6;
      final alpha = gameOver ? 0.3 : ratio;
      final segColor = isHead
          ? const Color(0xFF73FFE3)
          : Color.lerp(const Color(0xFF26E0A6), const Color(0xFF0A3A30), i / snake.length)!;

      if (isHead) {
        // Head glow
        final headGlowPaint = Paint()
          ..color = const Color(0xFF73FFE3).withValues(alpha: 0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(seg.x * cellSize + 1.5, seg.y * cellSize + 1.5, cellSize - 3, cellSize - 3),
            const Radius.circular(3),
          ),
          headGlowPaint,
        );
      }

      final segPaint = Paint()..color = segColor.withValues(alpha: alpha);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(seg.x * cellSize + 1.5, seg.y * cellSize + 1.5, cellSize - 3, cellSize - 3),
          Radius.circular(isHead ? 4 : 2),
        ),
        segPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SnakeGridPainter old) =>
      old.snake != snake || old.food != food || old.glowOpacity != glowOpacity || old.gameOver != gameOver;
}
