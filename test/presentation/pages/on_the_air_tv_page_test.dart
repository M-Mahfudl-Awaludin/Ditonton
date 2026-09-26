import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_cubit.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_page.dart';
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
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVListCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVListState(onTheAirState: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTVPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVListState(onTheAirState: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(const TVListState(
      onTheAirState: RequestState.Error,
      message: 'Error message',
    ));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTVPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });
}
