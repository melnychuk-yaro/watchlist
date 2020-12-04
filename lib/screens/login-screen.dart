import 'package:flutter/material.dart';
import 'package:watchlist/widgets/login-form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 16.0),
              width: 300.0,
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
