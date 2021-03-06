import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  final IconData icon;
  const StyledText({
    required this.text,
    this.icon = Icons.local_movies,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
