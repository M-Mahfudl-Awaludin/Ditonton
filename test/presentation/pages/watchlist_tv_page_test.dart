import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistTVCubit extends MockCubit<WatchlistTVState>
    implements WatchlistTVCubit {}

void main() {
  late MockWatchlistTVCubit mockCubit;

  setUp(() {
    mockCubit = MockWatchlistTVCubit();
    when(() => mockCubit.fetchWatchlistTV()).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTVCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(
        const WatchlistTVState(watchlistState: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(
        const WatchlistTVState(watchlistState: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const WatchlistTVState(
      watchlistState: RequestState.Error,
      message: 'Error message',
    ));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });
}
