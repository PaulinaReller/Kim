// Screen 1 Welcome 

import 'package:flutter/material.dart';
import '../widgets/Kim_logo.dart';
import '../widgets/slider.dart'; 

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
      
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PulsingLogo(),
                  const SizedBox(height: 40),

                  
                  const Text(
                    'Deine Reise mit KIM startet hier',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Deine einfühlsame digitale Begleiterin für Schmerzprävention und nachhaltige Unterstützung im Alltag - mit evidenzbasierter Komplementärmedizin.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300, 
                      color: const Color(0xFF1E1E1E), 
                    ),
                  ),
                  const SizedBox(height: 50),

                  AnimatedStartButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}