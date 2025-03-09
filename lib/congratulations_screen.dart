import 'package:flutter/material.dart';
import 'floor_selection_screen.dart';

class CongratulationsScreen extends StatelessWidget {
  final int finalScore;
  const CongratulationsScreen({Key? key, required this.finalScore})
    : super(key: key);

  void _showScoreDetails(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Score Details'),
            content: Text(
              'Your final score is $finalScore points.\nGreat job on the hunt!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'You have found the hidden marker!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              Image.asset('assets/face.png', height: 150, fit: BoxFit.contain),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _showScoreDetails(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: Colors.amber, width: 2),
                ),
                child: Text('View Score Details'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FloorSelectionScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: Colors.amber, width: 2),
                ),
                child: Text('Back to Floor Selection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
