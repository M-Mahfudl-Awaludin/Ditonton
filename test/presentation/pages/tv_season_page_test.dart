import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/pages/tv_season_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTVDetailCubit extends MockCubit<TVDetailState>
    implements TVDetailCubit {}

void main() {
  late MockTVDetailCubit mockCubit;

  setUp(() {
    mockCubit = MockTVDetailCubit();
    when(() => mockCubit.fetchSeasonDetail(any(), any()))
        .thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVDetailCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  TVSeasonPage _seasonPage() => TVSeasonPage(
        id: 1399,
        seasonNumber: 1,
        seasonName: 'Season 1',
      );

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVDetailState(seasonState: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(_seasonPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display the season name in the app bar',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVDetailState(seasonState: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(_seasonPage()));

    expect(find.text('Season 1'), findsOneWidget);
  });

  testWidgets('Page should display episode list when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TVDetailState(
      seasonState: RequestState.Loaded,
      seasonDetail: testTVSeasonDetail,
    ));

    await tester.pumpWidget(_makeTestableWidget(_seasonPage()));

    expect(find.byKey(Key('episodeList')), findsOneWidget);
    expect(find.textContaining('Episode'), findsWidgets);
  });

  testWidgets(
      'Page should display empty message when loaded with no episodes',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TVDetailState(
      seasonState: RequestState.Loaded,
      seasonDetail: TVSeasonDetail(
        id: testTVSeasonDetail.id,
        name: testTVSeasonDetail.name,
        overview: testTVSeasonDetail.overview,
        seasonNumber: testTVSeasonDetail.seasonNumber,
        posterPath: testTVSeasonDetail.posterPath,
        airDate: testTVSeasonDetail.airDate,
        episodes: const [],
      ),
    ));

    await tester.pumpWidget(_makeTestableWidget(_seasonPage()));

    expect(find.text('No episode data available'), findsOneWidget);
  });

  testWidgets('Page should display error message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const TVDetailState(
      seasonState: RequestState.Error,
      message: 'Error message',
    ));

    await tester.pumpWidget(_makeTestableWidget(_seasonPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
}
