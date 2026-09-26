import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTVDetailCubit extends MockCubit<TVDetailState>
    implements TVDetailCubit {}

class FakeTVDetail extends Fake implements TVDetail {}

void main() {
  late MockTVDetailCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeTVDetail());
  });

  setUp(() {
    mockCubit = MockTVDetailCubit();
    when(() => mockCubit.fetchTVDetail(any())).thenAnswer((_) async {});
    when(() => mockCubit.loadWatchlistStatus(any())).thenAnswer((_) async {});
    when(() => mockCubit.addWatchlist(any())).thenAnswer((_) async {});
    when(() => mockCubit.removeFromWatchlist(any())).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVDetailCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TVDetailState(
      tvState: RequestState.Loaded,
      tv: testTVDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const <TV>[],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv series is added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TVDetailState(
      tvState: RequestState.Loaded,
      tv: testTVDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const <TV>[],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TVDetailState(
      tvState: RequestState.Loaded,
      tv: testTVDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const <TV>[],
      isAddedToWatchlist: false,
      watchlistMessage: TVDetailCubit.watchlistAddSuccessMessage,
    ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(TVDetailCubit.watchlistAddSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TVDetailState(
      tvState: RequestState.Loaded,
      tv: testTVDetail,
      recommendationState: RequestState.Loaded,
      tvRecommendations: const <TV>[],
      isAddedToWatchlist: false,
      watchlistMessage: 'Failed',
    ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
