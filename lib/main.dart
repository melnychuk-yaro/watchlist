import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/favorites_bloc.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/business_logic/cubit/auth_cubit.dart';
import 'package:watchlist/business_logic/cubit/now_playing_cubit.dart';
import 'package:watchlist/business_logic/cubit/top_movies_cubit.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';
import 'package:watchlist/presentation/screens/home-screen.dart';
import 'package:watchlist/presentation/screens/login-screen.dart';
import 'package:watchlist/themes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WatchListApp());
}

class WatchListApp extends StatelessWidget {
  final _authenticationRepository = AuthenticationRepository();
  final _moviesRepository = MoviesRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist',
      theme: DefautTheme().theme,
      home: BlocBuilder<AuthCubit, AuthState>(
        cubit: AuthCubit(_authenticationRepository),
        builder: (context, state) {
          if (state is AuthInitial) {
            return Center(child: CircularProgressIndicator());
          }
          return state is AuthLoggedIn
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider<FavoritesBloc>(
                        create: (context) => FavoritesBloc(_moviesRepository)),
                    BlocProvider<SearchBloc>(
                        create: (context) => SearchBloc(_moviesRepository)),
                    BlocProvider<TopMoviesCubit>(
                        create: (context) => TopMoviesCubit(_moviesRepository)),
                    BlocProvider<NowPlayingCubit>(
                        create: (context) =>
                            NowPlayingCubit(_moviesRepository)),
                  ],
                  child: HomeScreen(),
                )
              : LoginScreen();
        },
      ),
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
