import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode;
  var authRepository = AuthenticationRepository();
  var _isLogin = true;
  var _email = '';
  var _password = '';
  var _loading = false;

  @override
  void initState() {
    super.initState();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    passwordFocusNode.dispose();
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
      case 'email-already-in-use':
        return 'Email already used. Go to login page.';
        break;
      case 'wrong-password':
        return 'Wrong email/password combination.';
        break;
      case 'user-not-found':
        return 'No user found with this email.';
        break;
      case 'user-disabled':
        return 'User disabled.';
        break;
      case 'operation-not-allowed':
        return 'Too many requests to log into this account.';
        break;
      case 'operation-not-allowed':
        return 'Server error, please try again later.';
        break;
      case 'invalid-email':
        return 'Email address is invalid.';
        break;
      case 'user-not-found':
        return 'No account found with this email';
        break;
      case 'email-already-in-use':
        return 'Email alredy in use';
        break;
      case 'invalid-email':
        return 'The email address is not valid';
        break;
      case 'weak-password':
        return 'Please use more secure password with at least 6 chars';
        break;
      case 'operation-not-allowed':
        return 'Something went wrong. Please contact support';
        break;
      default:
        return 'Something went wrong. Please try again or contact support.';
        break;
    }
  }

  Future<void> _register() async {
    setState(() => _loading = true);
    try {
      await authRepository.signUp(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(_getFirebaseAuthErrorMessage(e.code)),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      await authRepository.logInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(_getFirebaseAuthErrorMessage(e.code)),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => _email = value,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Padding(
                child: Icon(Icons.email, color: Theme.of(context).hintColor),
                padding: EdgeInsets.only(left: 16, right: 10),
              ),
            ),
            validator: (value) {
              RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!exp.hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            onChanged: (value) => _password = value,
            onFieldSubmitted: (_) {
              if (_isLogin) {
                _login();
              } else {
                _register();
              }
            },
            focusNode: passwordFocusNode,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Padding(
                child: Icon(Icons.vpn_key, color: Theme.of(context).hintColor),
                padding: EdgeInsets.only(left: 16, right: 10),
              ),
            ),
            validator: (value) {
              if (value.trim().length < 6) {
                return 'Must be at least 6 characters long.';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          _loading
              ? SizedBox(
                  height: 48.0,
                  width: 48.0,
                  child: CircularProgressIndicator(),
                )
              : _isLogin
                  ? Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _login();
                            }
                          },
                          child: Text('Login'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _register();
                        }
                      },
                      child: Text('Sign Up'),
                    ),
          SignInButton(
            Buttons.GoogleDark,
            onPressed: () => authRepository.logInWithGoogle(),
          ),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(child: Divider(color: Colors.white)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('OR'),
              ),
              Expanded(child: Divider(color: Colors.white)),
            ],
          ),
          _isLogin
              ? TextButton(
                  onPressed: () {
                    setState(() => _isLogin = false);
                  },
                  child: Text('Create a new account'),
                )
              : TextButton(
                  onPressed: () {
                    setState(() => _isLogin = true);
                  },
                  child: Text('Already have an account?'),
                )
        ],
      ),
    );
  }
}
