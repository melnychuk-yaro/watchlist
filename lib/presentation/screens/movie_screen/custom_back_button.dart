import 'package:flutter/material.dart';

import '../../../constatns.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
            boxShadow: kShadow,
          ),
          child: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? BackButton(color: kLightText)
              : BackButton(color: kDarkText),
        ),
      ),
    );
  }
}
