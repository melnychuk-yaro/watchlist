import 'package:flutter/material.dart';

import '../../constatns.dart';

class LogoCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: kPadding * 2 + 5,
      backgroundColor: Theme.of(context).cardColor,
      child: const CircleAvatar(
        radius: kPadding * 2,
        backgroundImage: AssetImage('assets/images/logo-padding.png'),
      ),
    );
  }
}
