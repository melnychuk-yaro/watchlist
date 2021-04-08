import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/cubit/login_cubit.dart';
import '../../../constatns.dart';
import '../../../data/models/password.dart';
import 'button_loading_indicator.dart';
import 'email_form_field.dart';
import 'password_form_field.dart';

class LoginForm extends StatefulWidget {
  final Function toggleIsLogin;
  LoginForm({required this.toggleIsLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, loginState) {
        if (loginState.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(loginState.errorMsg),
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
            _PasswordInput(passwordFocusNode: passwordFocusNode),
            const SizedBox(height: kPadding),
            _LoginButton(),
            const SizedBox(height: kPadding / 2),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
            ),
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
              child: Text(AppLocalizations.of(context)!.create_new_account),
            ),
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return EmailFormField(
          nextFieldFocusNode: nextFieldFocusNode,
          onChange: (email) => context.read<LoginCubit>().emailChanged(email),
          isInvalid: state.email.invalid,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({required this.passwordFocusNode});

  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return PasswordFormField(
          onChange: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          onFieldSubmitted: (_) {
            return context.read<LoginCubit>().logInWithCredentials();
          },
          focusNode: passwordFocusNode,
          hintText: AppLocalizations.of(context)!.password,
          errorText: state.password.error == PasswordValidationError.short
              ? AppLocalizations.of(context)!.password_to_short
              : null,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const ButtonLoadingIndicator()
            : ElevatedButton(
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: Text(AppLocalizations.of(context)!.login),
              );
      },
    );
  }
}
