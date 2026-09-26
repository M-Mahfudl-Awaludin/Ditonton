import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(home: body);
  }

  testWidgets('AboutPage should display the app description text',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(
      find.textContaining('Ditonton merupakan sebuah aplikasi katalog film'),
      findsOneWidget,
    );
  });

  testWidgets('AboutPage should display the app logo image',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('AboutPage back button should pop the route',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutPage()),
                );
              },
              child: Text('Open About'),
            ),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open About'));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsNothing);
  });
}
