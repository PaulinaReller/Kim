import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Make sure to import the welcome screen
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
      // This tells the app to start at the '/' route
      initialRoute: '/',
      // This is the directory of all screens
      routes: {
        // This line was missing:
        '/': (context) => const WelcomeScreen(), // The actual home screen widget
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
