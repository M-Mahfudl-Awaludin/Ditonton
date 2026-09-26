import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_cubit.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVListCubit extends MockCubit<TVListState> implements TVListCubit {}

void main() {
  late MockTVListCubit mockCubit;

  setUp(() {
    mockCubit = MockTVListCubit();
    when(() => mockCubit.fetchOnTheAirTV()).thenAnswer((_) async {});
    when(() => mockCubit.fetchPopularTV()).thenAnswer((_) async {});
    when(() => mockCubit.fetchTopRatedTV()).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVListCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  void _stubAllLoaded() {
    when(() => mockCubit.state).thenReturn(const TVListState(
      onTheAirState: RequestState.Loaded,
      onTheAirTV: <TV>[],
      popularTVState: RequestState.Loaded,
      popularTV: <TV>[],
      topRatedTVState: RequestState.Loaded,
      topRatedTV: <TV>[],
    ));
  }

  testWidgets('Page should display three section headings when loaded',
      (WidgetTester tester) async {
    _stubAllLoaded();

    await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

    expect(find.text('On The Air'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  });

  testWidgets('Page should display progress bars when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const TVListState(
      onTheAirState: RequestState.Loading,
      popularTVState: RequestState.Loading,
      topRatedTVState: RequestState.Loading,
    ));

    await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('Page should open the drawer with navigation entries',
      (WidgetTester tester) async {
    _stubAllLoaded();

    await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

    final scaffoldState =
        tester.firstState<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('TV Series'), findsOneWidget);
    expect(find.text('Watchlist TV Series'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Page should display a search icon button',
      (WidgetTester tester) async {
    _stubAllLoaded();

    await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
