import 'package:flutter/material.dart';

import '../../../constatns.dart';

class Backdrop extends StatelessWidget {
  const Backdrop({
    Key? key,
    required this.backdropPath,
  }) : super(key: key);

  final String backdropPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: kShadow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kBorderRadius * 2),
        ),
      ),
      child: Image.network(
        backdropPath,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Container(color: Colors.grey);
        },
      ),
    );
  }
}
