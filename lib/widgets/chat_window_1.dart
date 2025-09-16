import 'dart:ui';
import 'package:flutter/material.dart';

class ChatWindow extends StatelessWidget {
  const ChatWindow({
    super.key,
    required this.title,
    required this.body,
    required this.onClose,
  });

  final String title;
  final String body;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Header Row
              Row(
                children: [
                  IconButton(
                    // --- MODIFICATION HERE ---
                    alignment: Alignment.centerLeft, // This aligns the icon
                    // --- END MODIFICATION ---

                    // We leave the default padding, which is 8.0
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: onClose, // Use the callback
                  ),
                   const Text('Textansicht',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Content Area
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          height: 1.4, 
                        ),
                        children: [
                          // Styled title
                          TextSpan(
                            text: '$title\n\n',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          // Styled body
                          TextSpan(
                            text: body,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}