import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../business_logic/cubit/login_cubit.dart';
import '../../constatns.dart';
import '../../data/models/password.dart';
import 'button_loading_indicator.dart';

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
  const _EmailInput({
    Key? key,
    required this.nextFieldFocusNode,
  }) : super(key: key);

  final FocusNode nextFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(nextFieldFocusNode);
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.email,
            prefixIcon: Padding(
              child: Icon(Icons.email, color: Theme.of(context).hintColor),
              padding: EdgeInsets.only(left: kPadding, right: 10),
            ),
            errorText: state.email.invalid
                ? AppLocalizations.of(context)!.invalid_email
                : null,
          ),
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
        return TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          onFieldSubmitted: (_) =>
              context.read<LoginCubit>().logInWithCredentials(),
          focusNode: passwordFocusNode,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.password,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: kPadding, right: 10),
              child: Icon(Icons.vpn_key, color: Theme.of(context).hintColor),
            ),
            errorText: state.password.error == PasswordValidationError.short
                ? AppLocalizations.of(context)!.password_to_short
                : null,
          ),
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
            ? ButtonLoadingIndicator()
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
