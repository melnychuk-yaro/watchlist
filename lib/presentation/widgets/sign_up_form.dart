import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../business_logic/cubit/sign_up_cubit.dart';
import '../../data/models/confirmed_password.dart';
import '../../data/models/password.dart';
import 'button_loading_indicator.dart';

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
            const SizedBox(height: 16),
            _PasswordInput(
              focusNode: passwordFocusNode,
              nextFieldFocusNode: confirmedPasswordFocusNode,
            ),
            const SizedBox(height: 16),
            _PasswordConfirmInput(focusNode: confirmedPasswordFocusNode),
            const SizedBox(height: 16),
            _SignUpButton(),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(child: Divider(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text('OR'),
                ),
                Expanded(child: Divider(color: Colors.white)),
              ],
            ),
            TextButton(
              onPressed: () => widget.toggleIsLogin(),
              child: const Text('Already have an account?'),
            )
          ],
        ),
      ),
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
            ? ButtonLoadingIndicator()
            : ElevatedButton(
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('Sign Up'),
              );
      },
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
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(nextFieldFocusNode),
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Padding(
              child: Icon(Icons.email, color: Theme.of(context).hintColor),
              padding: EdgeInsets.only(left: 16, right: 10),
            ),
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
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
        return TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(nextFieldFocusNode),
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: Icon(Icons.vpn_key, color: Theme.of(context).hintColor),
            ),
            errorText: state.password.error == PasswordValidationError.short
                ? 'Password is to short'
                : null,
          ),
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
        return TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: (password) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(password),
          onFieldSubmitted: (_) =>
              context.read<SignUpCubit>().signUpFormSubmitted(),
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: Icon(Icons.vpn_key, color: Theme.of(context).hintColor),
            ),
            errorText: state.confirmedPassword.error ==
                    ConfirmedPasswordValidationError.unmatch
                ? 'Passwords don\'t match'
                : null,
          ),
        );
      },
    );
  }
}
