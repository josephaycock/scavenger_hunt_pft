import 'package:flutter/material.dart';
import 'floor_plan_screen.dart'; // Import the floor display screen
import 'game_stats.dart'; // Import the global stats class

class FloorSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple, // Purple background
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          40,
        ), // Extra bottom padding
        child: Column(
          children: [
            // Logo at the top center
            Image.asset(
              'assets/logo.png',
              height: 300, // Adjust size as needed
            ),
            SizedBox(height: 20),
            // Introductory text
            Expanded(
              child: Center(
                child: Text(
                  "Select a floor and track down the hidden marker.\nGood luck on your hunt!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text on purple
                  ),
                ),
              ),
            ),
            // Buttons at the bottom center for floor selection
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Rounded corners
                    ),
                    side: BorderSide(
                      color: Colors.amber, // Golden outline
                      width: 2,
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
                    side: BorderSide(color: Colors.amber, width: 2),
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
                    side: BorderSide(color: Colors.amber, width: 2),
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
                SizedBox(height: 20),
                // New button for viewing hunt stats
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.amber, width: 2),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text('Hunt Stats'),
                            content: Text(
                              'Hunts Completed: ${GameStats.huntsCompleted}\n'
                              'Total Score: ${GameStats.totalScore}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Close'),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Text("View Hunt Stats"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
