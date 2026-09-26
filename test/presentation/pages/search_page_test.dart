import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_cubit.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieSearchCubit extends MockCubit<MovieSearchState>
    implements MovieSearchCubit {}

void main() {
  late MockMovieSearchCubit mockCubit;

  setUp(() {
    mockCubit = MockMovieSearchCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display search field', (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const MovieSearchState(state: RequestState.Empty));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const MovieSearchState(state: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const MovieSearchState(state: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}
