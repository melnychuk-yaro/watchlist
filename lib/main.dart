import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/favorites_bloc.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/business_logic/bloc/auth_bloc.dart';
import 'package:watchlist/business_logic/cubit/all_favorites_cubit.dart';
import 'package:watchlist/business_logic/cubit/now_playing_cubit.dart';
import 'package:watchlist/business_logic/cubit/sign_up_cubit.dart';
import 'package:watchlist/business_logic/cubit/top_movies_cubit.dart';
import 'package:watchlist/data/repositories/auth_repository.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';
import 'package:watchlist/presentation/screens/home-screen.dart';
import 'package:watchlist/presentation/screens/auth-screen.dart';
import 'package:watchlist/presentation/themes/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'business_logic/cubit/login_cubit.dart';

Future<void> main() async {
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  final _authRepository = AuthenticationRepository();
  final _moviesRepository = MoviesRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(_authRepository)),
        BlocProvider(create: (_) => LoginCubit(_authRepository)),
        BlocProvider(create: (_) => SignUpCubit(_authRepository)),
      ],
      child: MaterialApp(
        title: 'Watchlist',
        theme: AppTheme().lightTheme,
        darkTheme: AppTheme().darkTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStatus.unknown) {
              return Center(child: CircularProgressIndicator());
            }
            return state.status == AuthStatus.authenticated
                ? MultiBlocProvider(
                    providers: [
                      BlocProvider<FavoritesBloc>(
                        create: (context) => FavoritesBloc(
                          _moviesRepository,
                          context.read<AuthBloc>(),
                        ),
                      ),
                      BlocProvider<AllFavoritesCubit>(
                        create: (context) => AllFavoritesCubit(
                          _moviesRepository,
                          context.read<AuthBloc>(),
                        ),
                      ),
                      BlocProvider<SearchBloc>(
                        create: (context) => SearchBloc(_moviesRepository),
                      ),
                      BlocProvider<TopMoviesCubit>(
                        create: (context) => TopMoviesCubit(_moviesRepository),
                      ),
                      BlocProvider<NowPlayingCubit>(
                        create: (context) => NowPlayingCubit(_moviesRepository),
                      ),
                    ],
                    child: HomeScreen(),
                  )
                : AuthScreen();
          },
        ),
      ),
    );
  }
}
