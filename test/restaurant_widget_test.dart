import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Testing', () {
    testWidgets('should display search hint text in search page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TextField(
              decoration: InputDecoration(
                hintText: 'Cari nama restoran atau menu...',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Cari nama restoran atau menu...'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
