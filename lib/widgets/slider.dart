import 'package:flutter/material.dart';

class AnimatedStartButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AnimatedStartButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Using a constant for the primary color makes it easy to change later
    const Color primaryColor = Color(0xFF0B5345); // A dark, elegant green

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        // Padding inside the main container
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.transparent, // No white fill
          // Creates the rounded corners
          borderRadius: BorderRadius.circular(50.0),
          // Defines the black border
          border: Border.all(color: Colors.black87, width: 1.5),
        ),
        child: Row(
          // Makes the Row only as wide as its children
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Concentric Circles
            SizedBox(
              width: 44,
              height: 44,
              // Stack allows layering widgets on top of each other
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer circle
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 3.5),
                    ),
                  ),
                  // Inner circle
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // 2. Fading Chevrons (Static version)
            Icon(Icons.chevron_right, color: primaryColor, size: 28),
            Icon(Icons.chevron_right,
                color: primaryColor.withOpacity(0.6), size: 28),
            Icon(Icons.chevron_right,
                color: primaryColor.withOpacity(0.3), size: 28),

            const SizedBox(width: 24),

            // 3. Text Label
            const Text(
              'Lass uns beginnen!',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Swiss 721', // Using your app's font
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            // A little extra space at the end for balance
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}