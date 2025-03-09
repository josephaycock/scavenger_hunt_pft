import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'congratulations_screen.dart'; // Import the congratulations screen

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

  @override
  void initState() {
    super.initState();
    _loadImageDimensions();
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
      // AppBar removed
      body: Container(
        color: Colors.purple, // Purple background
        alignment: Alignment.center,
        child:
            (originalWidth == null || originalHeight == null)
                ? const CircularProgressIndicator() // Wait for image size to load
                : LayoutBuilder(
                  builder: (context, constraints) {
                    // 1) Compute the image's aspect ratio
                    double aspectRatio = originalWidth! / originalHeight!;

                    // 2) Determine the maximum container size to fit the screen
                    //    We'll scale to 90% width and up to 80% height if needed.
                    double maxW = constraints.maxWidth * 0.9;
                    double maxH = constraints.maxHeight * 0.8;

                    // 3) Scale the container to keep the image aspect ratio
                    double containerWidth = maxW;
                    double containerHeight = containerWidth / aspectRatio;

                    // If it's too tall, shrink by height
                    if (containerHeight > maxH) {
                      containerHeight = maxH;
                      containerWidth = containerHeight * aspectRatio;
                    }

                    // 4) Once we know the final container size, place a gold border around it
                    //    and put the image + marker inside a Stack.
                    double markerSize = 40;

                    // If random coords not set yet, generate them so the marker is inside the container
                    if (randomX == null || randomY == null) {
                      final random = Random();
                      randomX =
                          random.nextDouble() * (containerWidth - markerSize);
                      randomY =
                          random.nextDouble() * (containerHeight - markerSize);
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
                          // Floor Plan Image - fill the container exactly
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                _getImagePath(widget.floorNumber),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          // Marker inside container boundaries
                          Positioned(
                            left: randomX!,
                            top: randomY!,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to CongratulationsScreen when marker is tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CongratulationsScreen(),
                                  ),
                                );
                              },
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
