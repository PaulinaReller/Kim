import 'package:flutter/material.dart';
import '../widgets/Kim_logo.dart';
import '../widgets/chat_window_1.dart';
import '../widgets/beginner_footer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final String _title = 'KIM';
  final String _body =
      'Ich erkundige mich nach deinem Befinden, erkläre dir wissenschaftliche Zusammenhänge leicht verständlich und gebe dir gezielte Empfehlungen. Ich bin da, um dich Schritt für Schritt auf deinem Weg für mehr Wohlbefinden zu unterstützen.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // --- MODIFICATION START ---
                      // Changed to stretch to allow left-aligned text
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Added the new header
                        const Text(
                          'Deine empathische Begleiterin KIM',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 30), // Added spacer
                        // --- MODIFICATION END ---
                        const PulsingLogo(),
                        const SizedBox(height: 24),
                        ChatWindow(
                          title: _title,
                          body: _body,
                          onClose: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  BeginnerFooter(
                    pageCount: 4,
                    activeIndex: 0,
                    onBack: () {
                      print('Back button pressed');
                    },
                    onForward: () {
                      print('Forward button pressed');
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