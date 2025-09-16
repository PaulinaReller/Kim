import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Make sure to import the welcome screen

// 1. This import is correct (it points to your file)
import 'screens/chat_screen.dart';

void main() {
  runApp(const GeminiApp());
}

class GeminiApp extends StatelessWidget {
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KIM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        
        // 2. THIS IS THE FIX:
        // Call the OnboardingScreen class, which lives
        // inside your chat_screen.dart file.
        '/chat': (context) => const OnboardingScreen(),
      },
    );
  }
}
