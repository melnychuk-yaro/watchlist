import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:watchlist/screens/favorites-screen.dart';
import 'package:watchlist/screens/login-screen.dart';
import 'package:watchlist/themes.dart';

void main() {
  runApp(WatchListApp());
}

class WatchListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist',
      theme: DefautTheme().theme,
      home: FutureBuilder<Object>(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return ErrorText();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<Object>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ErrorText();
                  }

                  if (snapshot.data == null) {
                    return LoginScreen();
                  } else {
                    return FavoritesScreen();
                  }
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ErrorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Something went wrong. Please try again later or contact support.'),
    );
  }
}
