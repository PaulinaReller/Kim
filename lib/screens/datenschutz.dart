//Screen 9 Datenschutz 

import 'package:flutter/material.dart';
import 'onboarding_roadmap.dart';

class DatenschutzScreen extends StatefulWidget {
  const DatenschutzScreen({super.key});

  @override
  State<DatenschutzScreen> createState() => _DatenschutzScreenState();
}

class _DatenschutzScreenState extends State<DatenschutzScreen> {
  bool _personalAgreed = false;
  bool _researchAgreed = false;
  bool _updatesAgreed = false;

  final Color kimGreen = const Color(0xFF03513A);

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
          Container(
          
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20), 
                  Text(
                    'KIM4U',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kimGreen,
                    ),
                  ),
                  const SizedBox(height: 80), 

                  const Text(
                    'Datenschutz',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Deine Angaben sind vertraulich und werden verschlüsselt gespeichert.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                     
                      borderRadius: BorderRadius.circular(20), 
                    ),
                    child: Column(
                      children: [
                        _buildCheckboxRow(
                          value: _personalAgreed,
                          onChanged: (newValue) {
                            setState(() {
                              _personalAgreed = newValue ?? false;
                            });
                          },
                          
                          textWidget: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                              children: [
                                const TextSpan(text: 'Ich stimme der Verarbeitung meiner '),
                                TextSpan(
                                  text: 'Daten für personalisierte Empfehlungen',
                                  style: TextStyle(color: Colors.red[700]), 
                                ),
                                const TextSpan(text: ' zu.'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24), 
                        _buildCheckboxRow(
                          value: _researchAgreed,
                          onChanged: (newValue) {
                            setState(() {
                              _researchAgreed = newValue ?? false;
                            });
                          },
                          textWidget: const Text(
                            'Ich stimme der anonymisierten Nutzung meiner Daten für Forschungszwecke zu.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildCheckboxRow(
                          value: _updatesAgreed,
                          onChanged: (newValue) {
                            setState(() {
                              _updatesAgreed = newValue ?? false;
                            });
                          },
                          textWidget: const Text(
                            'Ich möchte Infos und Updates von KIM4U erhalten.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

               
                  const Text(
                    'Du kannst deine Zustimmung jederzeit in den Profileinstellungen wiederrufen.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const Spacer(),

               
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                       
                        print('Personalisiert: $_personalAgreed');
                        print('Forschung: $_researchAgreed');
                        print('Updates: $_updatesAgreed');
                         Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingRoadmapScreen(),
        ),
      );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kimGreen,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Weiter',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCheckboxRow({
    required bool value,
    required Function(bool?) onChanged,
    required Widget textWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: kimGreen,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(
              color: Colors.black54,
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: textWidget), 
      ],
    );
  }
}