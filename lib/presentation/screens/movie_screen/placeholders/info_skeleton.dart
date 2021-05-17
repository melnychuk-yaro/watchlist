import 'package:flutter/material.dart';

import 'text_skeleton.dart';

class InfoSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 4.0,
      children: [
        const TextSkeleton(width: 120),
        const TextSkeleton(width: 120),
        const TextSkeleton(width: 120),
        const TextSkeleton(width: 120),
      ],
    );
  }
}
