import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'congratulations_screen.dart'; // Import the congratulations screen
import 'game_stats.dart';

class FloorPlanScreen extends StatefulWidget {
  final int floorNumber;
  const FloorPlanScreen({Key? key, required this.floorNumber})
    : super(key: key);

  @override
  _FloorPlanScreenState createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {
  double? originalWidth;
  double? originalHeight;

  // We'll store the random marker position once computed
  double? randomX;
  double? randomY;

  // Timer and score variables
  int _timeLeft = 60; // 60 seconds for the game
  int _score = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadImageDimensions();
    _startTimer();
  }

  // Start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        // Time is up: cancel the timer and navigate to the Congratulations screen
        timer.cancel();
        _endGame();
      }
    });
  }

  // Cancel the timer and navigate to the end game screen
  void _endGame() {
    _timer?.cancel();
    // Update global stats
    GameStats.huntsCompleted++;
    GameStats.totalScore += _score;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CongratulationsScreen(finalScore: _score),
      ),
    );
  }

  // When the marker is tapped, update the score and end the game
  void _onMarkerTapped() {
    setState(() {
      _score += 10; // Increase score by 10 (or adjust as needed)
    });
    // For this example, we end the game immediately after finding the marker
    _endGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Load the actual width/height of the image so we can scale it properly
  Future<void> _loadImageDimensions() async {
    final String path = _getImagePath(widget.floorNumber);
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final image = frame.image;

    setState(() {
      originalWidth = image.width.toDouble();
      originalHeight = image.height.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple, // Purple background
      body: Column(
        children: [
          // Timer and Scoreboard display at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time: $_timeLeft s',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'Score: $_score',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
          // Floor plan container with marker
          Expanded(
            child: Center(
              child:
                  (originalWidth == null || originalHeight == null)
                      ? CircularProgressIndicator()
                      : LayoutBuilder(
                        builder: (context, constraints) {
                          // Compute image aspect ratio
                          double aspectRatio = originalWidth! / originalHeight!;
                          // Determine maximum container size
                          double maxW = constraints.maxWidth * 0.9;
                          double maxH = constraints.maxHeight * 0.8;
                          double containerWidth = maxW;
                          double containerHeight = containerWidth / aspectRatio;
                          if (containerHeight > maxH) {
                            containerHeight = maxH;
                            containerWidth = containerHeight * aspectRatio;
                          }
                          double markerSize = 40;
                          // Generate random marker position if not set
                          if (randomX == null || randomY == null) {
                            final random = Random();
                            randomX =
                                random.nextDouble() *
                                (containerWidth - markerSize);
                            randomY =
                                random.nextDouble() *
                                (containerHeight - markerSize);
                          }
                          return Container(
                            width: containerWidth,
                            height: containerHeight,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.amber,
                                width: 6,
                              ), // Gold border
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                // Floor plan image filling the container
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.asset(
                                      _getImagePath(widget.floorNumber),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                // Randomized marker within container boundaries
                                Positioned(
                                  left: randomX!,
                                  top: randomY!,
                                  child: GestureDetector(
                                    onTap: _onMarkerTapped,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: markerSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the correct asset path for each floor
  String _getImagePath(int floor) {
    switch (floor) {
      case 1:
        return 'assets/pft-floor-one.png';
      case 2:
        return 'assets/pft-floor-two.png';
      case 3:
        return 'assets/pft-floor-three.png';
      default:
        return 'assets/pft-floor-one.png';
    }
  }
}
