// Integration test for the TV Series search flow.
//
// Run with:
//   flutter test integration_test/app_test.dart
// or, on a connected device/emulator:
//   flutter test integration_test/app_test.dart -d <device_id>
//
// NOTE: This test exercises the real app (including real network calls to
// the TMDB API), so a working internet connection is required.

import 'package:ditonton/main.dart' as app;
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Ditonton TV Series end-to-end flow', () {
    testWidgets(
        'user can navigate to TV Series, search a title, and open its detail',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Start on the Movies home page.
      expect(find.byType(HomeMoviePage), findsOneWidget);

      // Open the drawer and go to TV Series.
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('TV Series'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(HomeTVPage), findsOneWidget);

      // Go to the TV search page.
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(SearchTVPage), findsOneWidget);

      // Search for a well-known title.
      await tester.enterText(find.byKey(Key('searchFieldTV')), 'Game of Thrones');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // At least one result card should appear.
      expect(find.text('Game of Thrones'), findsWidgets);

      // Tap the first result and verify the detail page opens.
      await tester.tap(find.text('Game of Thrones').first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(TVDetailPage), findsOneWidget);
    });
  });
}
