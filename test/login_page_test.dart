import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:babylon_flutter_app/pages/login_page.dart';

void main() {
  group('LoginPage Widget & Validation Tests', () {
    testWidgets('Shows error for empty email and password', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.text('Please enter your email address'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('Shows error for invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(find.byType(TextFormField).at(0), 'invalidemail');
      await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('Shows error for short password', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'short');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    });

    testWidgets('Valid input enables login button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
      await tester.pump();
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      final ElevatedButton button = tester.widget(loginButton);
      expect(button.onPressed, isNotNull);
    });

    testWidgets('Email field trims spaces and validates', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(find.byType(TextFormField).at(0), '  user@example.com  ');
      await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      expect(find.text('Please enter a valid email address'), findsNothing);
    });
  });
} 