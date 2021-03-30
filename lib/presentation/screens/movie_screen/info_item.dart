import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String defenition;
  final String value;
  const InfoItem({required this.defenition, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: '$defenition ',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
