import 'package:flutter/material.dart';
import 'floor_plan_screen.dart'; // Import the floor display screen

class FloorSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Floor")),
      body: Center(
        // Ensures everything is centered
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Ensures horizontal centering
          children: [
            Text(
              "Select the Floor",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
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
      ),
    );
  }
}
