import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movemate_ui/main_pages/HomePage.dart';

void main() {
  group('HomePage Tests', () {
    testWidgets('Search bar updates filtered data correctly', (WidgetTester tester) async {
      // Build the HomePage widget
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Ensure the search bar is displayed
      final searchBar = find.byType(TextField);
      expect(searchBar, findsOneWidget);

      // Type in the search bar
      await tester.enterText(searchBar, 'EGP20089934122232');
      await tester.pumpAndSettle();

      // Check if only matching items are displayed
      final trackingCard = find.textContaining('EGP20089934122232');
      expect(trackingCard, findsOneWidget);

      final nonMatchingCard = find.textContaining('EGP20089934122231');
      expect(nonMatchingCard, findsNothing);
    });

    testWidgets('Filter button updates filtered data correctly', (WidgetTester tester) async {
      // Build the HomePage widget
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Open the filter dialog
      final filterButton = find.byIcon(Icons.filter_alt_rounded);
      expect(filterButton, findsOneWidget);
      await tester.tap(filterButton);
      await tester.pumpAndSettle();

      // Select a filter option
      final filterOption = find.text('Departed from Cairo');
      expect(filterOption, findsOneWidget);
      await tester.tap(filterOption);
      await tester.pumpAndSettle();

      // Check if only filtered items are displayed
      final matchingCard = find.textContaining('Departed from Cairo');
      expect(matchingCard, findsOneWidget);

      final nonMatchingCard = find.textContaining('Arrived at Alexandria Hub');
      expect(nonMatchingCard, findsNothing);
    });
  });
}
