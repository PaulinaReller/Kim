
import 'package:flutter/material.dart';

class BeginnerFooter extends StatelessWidget {
  const BeginnerFooter({
    super.key,
    required this.pageCount,
    required this.activeIndex,
    required this.onBack,
    required this.onForward,
  });

  final int pageCount;
  final int activeIndex;
  final VoidCallback onBack;
  final VoidCallback onForward;

  static const Color _darkGreen = Color(0xFF03513A);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _darkGreen, width: 1.5),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: _darkGreen),
            onPressed: onBack,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(pageCount, (index) {
            return _buildDot(isActive: index == activeIndex);
          }),
        ),

        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: _darkGreen,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: onForward,
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? _darkGreen : Colors.transparent,
        border: Border.all(color: _darkGreen, width: 1.5),
      ),
    );
  }
}