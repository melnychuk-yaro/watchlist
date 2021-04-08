import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constatns.dart';

class EmailFormField extends StatelessWidget {
  EmailFormField({
    Key? key,
    required this.nextFieldFocusNode,
    required this.onChange,
    required this.isInvalid,
  }) : super(key: key);

  final FocusNode nextFieldFocusNode;
  final Function(String) onChange;
  final bool isInvalid;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: onChange,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFieldFocusNode);
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.email,
        prefixIcon: Padding(
          child: Icon(Icons.email, color: Theme.of(context).hintColor),
          padding: const EdgeInsets.only(left: kPadding, right: 10),
        ),
        errorText:
            isInvalid ? AppLocalizations.of(context)!.invalid_email : null,
      ),
    );
  }
}
