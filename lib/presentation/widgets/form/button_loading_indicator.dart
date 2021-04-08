import 'package:flutter/material.dart';

import '../../../constatns.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 48.0,
      width: 48.0,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
