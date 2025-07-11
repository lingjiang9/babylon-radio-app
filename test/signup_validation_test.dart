import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:babylon_flutter_app/pages/signup_page.dart';

void main() {
  group('SignupPage Widget Validation Tests', () {
    Future<void> pumpSignupPage(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SignupPage(),
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home Page')),
            '/login': (context) => const Scaffold(body: Text('Login Page')),
          },
        ),
      );
    }

    testWidgets('displays validation errors for empty fields', (tester) async {
      await pumpSignupPage(tester);
      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();
      expect(find.text('Please enter your first name'), findsOneWidget);
      expect(find.text('Please enter your last name'), findsOneWidget);
      expect(find.text('Please enter your email address'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('shows error for invalid email and password', (tester) async {
      await pumpSignupPage(tester);
      await tester.enterText(find.byType(TextFormField).at(0), 'John');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(2), 'invalidemail');
      await tester.enterText(find.byType(TextFormField).at(3), 'short');
      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    });
  });
} 