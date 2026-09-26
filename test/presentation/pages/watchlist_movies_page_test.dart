import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistMovieCubit extends MockCubit<WatchlistMovieState>
    implements WatchlistMovieCubit {}

void main() {
  late MockWatchlistMovieCubit mockCubit;

  setUp(() {
    mockCubit = MockWatchlistMovieCubit();
    when(() => mockCubit.fetchWatchlistMovies()).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(
        const WatchlistMovieState(watchlistState: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(
        const WatchlistMovieState(watchlistState: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const WatchlistMovieState(
      watchlistState: RequestState.Error,
      message: 'Error message',
    ));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });
}
