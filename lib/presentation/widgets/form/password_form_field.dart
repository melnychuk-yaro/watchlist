import 'package:flutter/material.dart';

import '../../../constatns.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    Key? key,
    required this.onChange,
    required this.onFieldSubmitted,
    required this.focusNode,
    required this.hintText,
    this.errorText,
  }) : super(key: key);

  final Function(String) onChange;
  final Function(String) onFieldSubmitted;
  final FocusNode focusNode;
  final String? errorText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: kPadding, right: 10),
          child: Icon(Icons.vpn_key, color: Theme.of(context).hintColor),
        ),
        errorText: errorText,
      ),
    );
  }
}
