//Screen 6 Log in 

import 'package:flutter/material.dart';
import '../widgets/Kim_logo.dart'; // Logo Import KIM 
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller für die Textfelder
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Farbdefiniton in assets ? 
  final Color kimGreen = const Color(0xFF03513A);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
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
            color: Colors.white.withOpacity(0.5), 
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20), 
                  
                  // KIM4U Text-Logo
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'KIM4U',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kimGreen, 
                      ),
                    ),
                  ),
                  
                  const Spacer(), 
                  
                  const PulsingLogo(),
                  
                  const SizedBox(height: 40),

                  // "Willkommen zurück!" Text
                  const Text(
                    'Willkommen zurück!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Logge dich ein, um deine Reise mit KIM fortzusetzen.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),

                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                   
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Passwort',
                    obscureText: true, 
                    
                  ),
                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        print('Passwort vergessen gedrückt');
                      },
                      child: const Text(
                        'Passwort vergessen?',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity, 
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Email: ${_emailController.text}');
                        print('Passwort: ${_passwordController.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kimGreen, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Noch kein Konto? ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    );
  },
  child: Text(
    'Jetzt registrieren',
    style: TextStyle(
      color: kimGreen,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
),
                    ],
                  ),
                  const Spacer(), 
                  const SizedBox(height: 20), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    IconData? icon,
  }) {
   
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black), 
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          prefixIcon: icon != null ? Icon(icon, color: Colors.black54) : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: InputBorder.none, 
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}