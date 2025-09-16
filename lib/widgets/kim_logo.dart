import 'package:flutter/material.dart';

// KIM Logo Stand 11.09.2025
class PulsingLogo extends StatefulWidget {
  const PulsingLogo({super.key});

  @override
  State<PulsingLogo> createState() => _PulsingLogoState();
}

class _PulsingLogoState extends State<PulsingLogo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildAnimatedRing(delay: 0.0),
          _buildAnimatedRing(delay: 0.5),
          _buildAnimatedRing(delay: 1.0),
        ],
      ),
    );
  }

  Widget _buildAnimatedRing({required double delay}) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.9, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(delay, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.2, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(delay, 1.0, curve: Curves.easeInOut),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF03513A), width: 8),
          ),
        ),
      ),
    );
  }
}