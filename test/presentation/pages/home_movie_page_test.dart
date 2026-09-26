import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_cubit.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListCubit extends MockCubit<MovieListState>
    implements MovieListCubit {}

void main() {
  late MockMovieListCubit mockCubit;

  setUp(() {
    mockCubit = MockMovieListCubit();
    when(() => mockCubit.fetchNowPlayingMovies()).thenAnswer((_) async {});
    when(() => mockCubit.fetchPopularMovies()).thenAnswer((_) async {});
    when(() => mockCubit.fetchTopRatedMovies()).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieListCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  void _stubAllLoaded() {
    when(() => mockCubit.state).thenReturn(const MovieListState(
      nowPlayingState: RequestState.Loaded,
      nowPlayingMovies: <Movie>[],
      popularMoviesState: RequestState.Loaded,
      popularMovies: <Movie>[],
      topRatedMoviesState: RequestState.Loaded,
      topRatedMovies: <Movie>[],
    ));
  }

  testWidgets('Page should display three section headings when loaded',
      (WidgetTester tester) async {
    _stubAllLoaded();

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  });

  testWidgets('Page should display progress bars when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const MovieListState(
      nowPlayingState: RequestState.Loading,
      popularMoviesState: RequestState.Loading,
      topRatedMoviesState: RequestState.Loading,
    ));

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('Page should open the drawer with navigation entries',
      (WidgetTester tester) async {
    _stubAllLoaded();

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    final scaffoldState =
        tester.firstState<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('TV Series'), findsOneWidget);
    expect(find.text('Watchlist Movies'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Page should display a search icon button',
      (WidgetTester tester) async {
    _stubAllLoaded();

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
