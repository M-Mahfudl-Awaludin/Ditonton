import 'dart:async';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_season_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Route every Flutter framework error (widget build errors, layout
  // errors, etc.) to Crashlytics instead of only printing to the console.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Route every error that isn't caught by Flutter's own error handling
  // (e.g. an error thrown in an async callback) to Crashlytics as well.
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await di.init();

  // runZonedGuarded gives us one last safety net: anything that still
  // slips past the handlers above (e.g. an error during `main` itself,
  // before the handlers are attached) is still reported.
  runZonedGuarded(
    () => runApp(MyApp()),
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<MovieListCubit>()),
        BlocProvider(create: (_) => di.locator<MovieDetailCubit>()),
        BlocProvider(create: (_) => di.locator<MovieSearchCubit>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesCubit>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesCubit>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieCubit>()),
        BlocProvider(create: (_) => di.locator<TVListCubit>()),
        BlocProvider(create: (_) => di.locator<TVDetailCubit>()),
        BlocProvider(create: (_) => di.locator<TVSearchCubit>()),
        BlocProvider(create: (_) => di.locator<PopularTVCubit>()),
        BlocProvider(create: (_) => di.locator<TopRatedTVCubit>()),
        BlocProvider(create: (_) => di.locator<WatchlistTVCubit>()),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: colorScheme,
          primaryColor: richBlack,
          scaffoldBackgroundColor: richBlack,
          textTheme: textTheme,
          drawerTheme: drawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [
          routeObserver,
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case OnTheAirTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case TVSeasonPage.ROUTE_NAME:
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => TVSeasonPage(
                  id: args['id'] as int,
                  seasonNumber: args['seasonNumber'] as int,
                  seasonName: args['seasonName'] as String,
                ),
                settings: settings,
              );
            case SearchTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
