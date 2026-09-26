import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTV = TV(
    backdropPath: '/backdrop.jpg',
    genreIds: [18, 10765],
    id: 1399,
    name: 'Game of Thrones',
    originalName: 'Game of Thrones',
    overview: 'Seven noble families fight for control of Westeros.',
    popularity: 369.594,
    posterPath: '/poster.jpg',
    firstAirDate: '2011-04-17',
    voteAverage: 8.3,
    voteCount: 11504,
  );

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(home: Scaffold(body: body));
  }

  testWidgets('TVCard should display tv name and overview',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(TVCard(tTV)));

    expect(find.text('Game of Thrones'), findsOneWidget);
    expect(
      find.text('Seven noble families fight for control of Westeros.'),
      findsOneWidget,
    );
  });

  testWidgets('TVCard should be tappable', (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(TVCard(tTV)));

    expect(find.byType(InkWell), findsOneWidget);
  });
}
