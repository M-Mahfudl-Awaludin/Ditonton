import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedTVCubit extends MockCubit<TopRatedTVState>
    implements TopRatedTVCubit {}

void main() {
  late MockTopRatedTVCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedTVCubit();
    when(() => mockCubit.fetchTopRatedTV()).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TopRatedTVState(state: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TopRatedTVState(state: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const TopRatedTVState(
      state: RequestState.Error,
      message: 'Error message',
    ));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });
}
