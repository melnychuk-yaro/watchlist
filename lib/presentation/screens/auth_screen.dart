import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/sign_up_form.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _AuthFormSwicher(),
        ),
      ),
    );
  }
}

class _AuthFormSwicher extends StatefulWidget {
  @override
  __AuthFormSwicherState createState() => __AuthFormSwicherState();
}

class __AuthFormSwicherState extends State<_AuthFormSwicher> {
  bool _isLogin = true;

  void _toggleIsLogin() {
    setState(() => _isLogin = !_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: _isLogin
          ? _LoginCard(
              key: ValueKey('login-form'),
              child: LoginForm(toggleIsLogin: _toggleIsLogin),
            )
          : _LoginCard(
              key: ValueKey('sign-up-form'),
              child: SignUpForm(toggleIsLogin: _toggleIsLogin),
            ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  _LoginCard({required this.key, required this.child}) : super(key: key);
  final Widget child;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 16.0),
        width: 300.0,
        child: child,
      ),
    );
  }
}
