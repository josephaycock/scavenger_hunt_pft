import 'package:flutter/material.dart';
import 'floor_selection_screen.dart'; // Fix import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scavenger Hunt',
      debugShowCheckedModeBanner: false,
      home: FloorSelectionScreen(), // Start at floor selection
    );
  }
}
