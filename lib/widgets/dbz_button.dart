import 'package:flutter/material.dart';


class DBZButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Color> colors;
  final IconData icon;

  const DBZButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.colors,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: isSelected ? colors : [Colors.grey[800]!, Colors.grey[900]!]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 3),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors[1].withOpacity(0.8),
                    blurRadius: 30,
                    spreadRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.white54, size: 32),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.white70,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}