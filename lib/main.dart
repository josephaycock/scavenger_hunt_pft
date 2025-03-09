import 'package:flutter/material.dart';
import 'welcome_screen.dart';

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
      home: WelcomeScreen(),
    );
  }
}
