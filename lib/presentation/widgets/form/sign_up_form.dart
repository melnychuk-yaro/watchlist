import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/cubit/sign_up_cubit.dart';
import '../../../constatns.dart';
import '../../../data/models/confirmed_password.dart';
import '../../../data/models/password.dart';
import 'button_loading_indicator.dart';
import 'email_form_field.dart';
import 'password_form_field.dart';

class SignUpForm extends StatefulWidget {
  final Function toggleIsLogin;
  SignUpForm({required this.toggleIsLogin});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmedPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    passwordFocusNode.dispose();
    confirmedPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, signUpState) {
        if (signUpState.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(signUpState.errorMsg),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(nextFieldFocusNode: passwordFocusNode),
            const SizedBox(height: kPadding),
            _PasswordInput(
              focusNode: passwordFocusNode,
              nextFieldFocusNode: confirmedPasswordFocusNode,
            ),
            const SizedBox(height: kPadding),
            _PasswordConfirmInput(focusNode: confirmedPasswordFocusNode),
            const SizedBox(height: kPadding),
            _SignUpButton(),
            const SizedBox(height: kPadding),
            Row(
              children: <Widget>[
                Expanded(child: Divider(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Text(AppLocalizations.of(context)!.or),
                ),
                Expanded(child: Divider(color: Colors.white)),
              ],
            ),
            TextButton(
              onPressed: () => widget.toggleIsLogin(),
              child: Text(AppLocalizations.of(context)!.have_account),
            )
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({required this.nextFieldFocusNode});

  final FocusNode nextFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return EmailFormField(
          nextFieldFocusNode: nextFieldFocusNode,
          onChange: (email) => context.read<SignUpCubit>().emailChanged(email),
          isInvalid: state.email.invalid,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    required this.focusNode,
    required this.nextFieldFocusNode,
  });

  final FocusNode focusNode;
  final FocusNode nextFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordFormField(
          onChange: (password) {
            context.read<SignUpCubit>().passwordChanged(password);
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(nextFieldFocusNode);
          },
          focusNode: focusNode,
          hintText: AppLocalizations.of(context)!.password,
          errorText: state.password.error == PasswordValidationError.short
              ? AppLocalizations.of(context)!.password_to_short
              : null,
        );
      },
    );
  }
}

class _PasswordConfirmInput extends StatelessWidget {
  const _PasswordConfirmInput({required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordFormField(
          onChange: (password) {
            context.read<SignUpCubit>().confirmedPasswordChanged(password);
          },
          onFieldSubmitted: (_) {
            return context.read<SignUpCubit>().signUpFormSubmitted();
          },
          focusNode: focusNode,
          hintText: AppLocalizations.of(context)!.confirm_password,
          errorText: state.confirmedPassword.error ==
                  ConfirmedPasswordValidationError.unmatch
              ? AppLocalizations.of(context)!.paswords_do_not_match
              : null,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const ButtonLoadingIndicator()
            : ElevatedButton(
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: Text(AppLocalizations.of(context)!.sign_up),
              );
      },
    );
  }
}
