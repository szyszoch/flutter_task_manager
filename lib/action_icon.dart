import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? background;

  const ActionIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: CircleBorder(),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, size: 24, color: color),
      ),
    );
  }
}
