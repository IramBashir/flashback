import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FlashbackApp());
}

class FlashbackApp extends StatelessWidget {
  const FlashbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashback',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF111111),
      ),
      home: const HomeScreen(),
    );
  }
}
