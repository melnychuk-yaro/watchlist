import 'package:flutter/material.dart';

import '../../constatns.dart';
import '../widgets/form/login_form.dart';
import '../widgets/form/sign_up_form.dart';
import '../widgets/logo_circle.dart';

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
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      switchInCurve: Curves.easeOut,
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
  static const double cardWidth = 300.0;
  static const double logoSize = 37.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // const SizedBox(height: logoSize),
          Container(
            padding: const EdgeInsets.fromLTRB(
              kPadding * 1.5,
              kPadding * 2.5,
              kPadding * 1.5,
              kPadding,
            ),
            width: cardWidth,
            child: child,
          ),
          Positioned(
            top: -logoSize,
            left: cardWidth / 2 - logoSize,
            child: LogoCircle(),
          ),
        ],
      ),
    );
  }
}
