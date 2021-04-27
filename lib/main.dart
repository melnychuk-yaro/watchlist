import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'business_logic/bloc/auth_bloc.dart';
import 'business_logic/bloc/favorites_bloc.dart';
import 'business_logic/bloc/search_bloc.dart';
import 'business_logic/cubit/all_favorites_cubit.dart';
import 'business_logic/cubit/login_cubit.dart';
import 'business_logic/cubit/now_playing_cubit.dart';
import 'business_logic/cubit/sign_up_cubit.dart';
import 'business_logic/cubit/single_movie_cubit.dart';
import 'business_logic/cubit/top_movies_cubit.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/favorites_repository.dart';
import 'data/repositories/movies_repository.dart';
import 'presentation/screens/auth_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/themes/app_theme.dart';

Future<void> main() async {
  await dot_env.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();

  runApp(App());
}

class App extends StatelessWidget {
  final _authRepository = AuthenticationRepository();
  final _moviesRepository = MoviesRepository();
  final _favoritesRepository = FavoritesRepository();

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
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ru', ''),
          const Locale('uk', ''),
        ],
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
                          _favoritesRepository,
                          context.read<AuthBloc>(),
                        ),
                      ),
                      BlocProvider<AllFavoritesCubit>(
                        create: (context) => AllFavoritesCubit(
                          _favoritesRepository,
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
                      BlocProvider<SingleMovieCubit>(
                        create: (context) =>
                            SingleMovieCubit(_moviesRepository),
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
