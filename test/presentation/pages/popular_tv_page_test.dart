import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_cubit.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularTVCubit extends MockCubit<PopularTVState>
    implements PopularTVCubit {}

void main() {
  late MockPopularTVCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularTVCubit();
    when(() => mockCubit.fetchPopularTV()).thenAnswer((_) async {});
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const PopularTVState(state: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const PopularTVState(state: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const PopularTVState(
      state: RequestState.Error,
      message: 'Error message',
    ));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });
}
