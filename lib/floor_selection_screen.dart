import 'package:flutter/material.dart';
import 'floor_plan_screen.dart'; // Import the floor display screen

class FloorSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Floor")),
      backgroundColor: Colors.purple, // Purple background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Intro text at the top
            Expanded(
              child: Center(
                child: Text(
                  "Select a floor and track down the hidden marker.\nGood luck on your hunt!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Buttons at the bottom center
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      double.infinity,
                      50,
                    ), // Full-width, height 50
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Rounded corners
                    ),
                  ),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FloorPlanScreen(floorNumber: 1),
                        ),
                      ),
                  child: Text("First Floor"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FloorPlanScreen(floorNumber: 2),
                        ),
                      ),
                  child: Text("Second Floor"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FloorPlanScreen(floorNumber: 3),
                        ),
                      ),
                  child: Text("Third Floor"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
