import 'package:flutter/material.dart';

import '../../constatns.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: Padding(
        padding: const EdgeInsets.all(kPadding / 2),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
