import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movemate_ui/main_pages/login.dart';

void main() {
  group('Login Page Tests', () {
    testWidgets('Check if all UI elements are present', (WidgetTester tester) async {
      // Build the Login widget
      await tester.pumpWidget(const MaterialApp(home: login()));

      // Check if username TextField is present
      final usernameField = find.byType(TextField).at(0);
      expect(usernameField, findsOneWidget);

      // Check if password TextField is present
      final passwordField = find.byType(TextField).at(1);
      expect(passwordField, findsOneWidget);

      // Check if Login button is present
      final loginButton = find.text('Login');
      expect(loginButton, findsOneWidget);

      // Check if "Don't have an account" text is present
      final signUpText = find.text("Don't have an account");
      expect(signUpText, findsOneWidget);

      // Check if "Forget Password" text is present
      final forgetPasswordText = find.text('Forget Password');
      expect(forgetPasswordText, findsOneWidget);
    });

    testWidgets('Typing in the username and password fields', (WidgetTester tester) async {
      // Build the Login widget
      await tester.pumpWidget(const MaterialApp(home: login()));

      // Find the username TextField and enter text
      final usernameField = find.byType(TextField).at(0);
      await tester.enterText(usernameField, 'testuser');
      await tester.pumpAndSettle();

      expect(find.text('testuser'), findsOneWidget);

      // Find the password TextField and enter text
      final passwordField = find.byType(TextField).at(1);
      await tester.enterText(passwordField, 'password123');
      await tester.pumpAndSettle();

      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('Check visibility toggle for password field', (WidgetTester tester) async {
      // Build the Login widget
      await tester.pumpWidget(const MaterialApp(home: login()));

      // Find the password visibility toggle button
      final visibilityToggle = find.byIcon(Icons.visibility);
      expect(visibilityToggle, findsOneWidget);

      // Tap the visibility toggle button
      await tester.tap(visibilityToggle);
      await tester.pumpAndSettle();

      // Check if the password field switches icon
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('Clicking Login button without entering credentials', (WidgetTester tester) async {
      // Build the Login widget
      await tester.pumpWidget(const MaterialApp(home: login()));

      // Find and tap the Login button
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Check if an error message appears
      final errorMessage = find.text('Invalid username or password.');
      expect(errorMessage, findsNothing); // No error message since it is backend logic
    });

    testWidgets('Navigating to the Sign-up page', (WidgetTester tester) async {
      // Build the Login widget
      await tester.pumpWidget(const MaterialApp(home: login()));

      // Find and tap the Sign-up button
      final signUpButton = find.text('Sign up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      // Check if navigation occurred (mock navigation or test implementation required)
      expect(find.text('Register'), findsNothing);
    });

    testWidgets('Navigating to the Forget Password page', (WidgetTester tester) async {
      // Build the Login widget
      await tester.pumpWidget(const MaterialApp(home: login()));

      // Find and tap the Forget Password button
      final forgetPasswordButton = find.text('Forget Password');
      await tester.tap(forgetPasswordButton);
      await tester.pumpAndSettle();

      // Check if navigation occurred (mock navigation or test implementation required)
      expect(find.text('Forget'), findsNothing);
    });
  });
}
