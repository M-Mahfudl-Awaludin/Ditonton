import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_cubit.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVSearchCubit extends MockCubit<TVSearchState>
    implements TVSearchCubit {}

void main() {
  late MockTVSearchCubit mockCubit;

  setUp(() {
    mockCubit = MockTVSearchCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSearchCubit>.value(
      value: mockCubit,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display search field', (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVSearchState(state: RequestState.Empty));

    await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

    expect(find.byKey(Key('searchFieldTV')), findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVSearchState(state: RequestState.Loading));

    await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const TVSearchState(state: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}
