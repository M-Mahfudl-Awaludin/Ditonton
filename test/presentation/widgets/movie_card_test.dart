import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview: 'After being bitten by a genetically altered spider.',
    popularity: 60.441,
    posterPath: '/poster.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(home: Scaffold(body: body));
  }

  testWidgets('MovieCard should display movie title and overview',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieCard(tMovie)));

    expect(find.text('Spider-Man'), findsOneWidget);
    expect(
      find.text('After being bitten by a genetically altered spider.'),
      findsOneWidget,
    );
  });

  testWidgets('MovieCard should be tappable', (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieCard(tMovie)));

    expect(find.byType(InkWell), findsOneWidget);
  });
}
