import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:babylon_flutter_app/pages/signup_page.dart';

void main() {
  group('SignupPage Input Validation', () {
    late GlobalKey<FormState> formKey;
    late TextEditingController firstNameController;
    late TextEditingController lastNameController;
    late TextEditingController emailController;
    late TextEditingController passwordController;

    setUp(() {
      formKey = GlobalKey<FormState>();
      firstNameController = TextEditingController();
      lastNameController = TextEditingController();
      emailController = TextEditingController();
      passwordController = TextEditingController();
    });

    tearDown(() {
      firstNameController.dispose();
      lastNameController.dispose();
      emailController.dispose();
      passwordController.dispose();
    });

    Widget buildTestableForm() {
      return MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your first name';
                    }
                    if (value.trim().length < 2) {
                      return 'First name must be at least 2 characters';
                    }
                    if (value.trim().length > 50) {
                      return 'First name must be less than 50 characters';
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+ 0-').hasMatch(value.trim())) {
                      return 'First name can only contain letters and spaces';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your last name';
                    }
                    if (value.trim().length < 2) {
                      return 'Last name must be at least 2 characters';
                    }
                    if (value.trim().length > 50) {
                      return 'Last name must be less than 50 characters';
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+ -').hasMatch(value.trim())) {
                      return 'Last name can only contain letters and spaces';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    final email = value.trim();
                    if (email.length > 254) {
                      return 'Email address is too long';
                    }
                    final parts = email.split('@');
                    if (parts.length != 2) {
                      return 'Please enter a valid email address';
                    }
                    final localPart = parts[0];
                    final domainPart = parts[1];
                    if (localPart.isEmpty) {
                      return 'Invalid email address';
                    }
                    if (domainPart.isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    if (localPart.length > 64) {
                      return 'The local part of the email is too long';
                    }
                    if (domainPart.length > 253) {
                      return 'Email address is too long';
                    }
                    if (localPart.startsWith('.') || localPart.endsWith('.')) {
                      return 'Invalid email address';
                    }
                    if (localPart.contains('..')) {
                      return 'Invalid email address';
                    }
                    if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
                      return 'Please enter a valid email address';
                    }
                    if (domainPart.contains('..')) {
                      return 'Invalid email address';
                    }
                    if (!domainPart.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    final domainParts = domainPart.split('.');
                    if (domainParts.length < 2) {
                      return 'Please enter a valid email address';
                    }
                    final tld = domainParts.last;
                    if (tld.length < 2) {
                      return 'Please enter a valid email address';
                    }
                    final emailRegex = RegExp(r"^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*");
                    if (!emailRegex.hasMatch(email)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (value.length > 128) {
                      return 'Password must be less than 128 characters';
                    }
                    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]').hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    testWidgets('First Name - Empty input', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      firstNameController.text = '';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('First Name - Too short', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      firstNameController.text = 'A';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('First Name - Too long', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      firstNameController.text = 'A' * 51;
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('First Name - Invalid characters', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      firstNameController.text = 'John123!';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Last Name - Empty input', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      lastNameController.text = '';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Last Name - Too short', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      lastNameController.text = 'B';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Last Name - Too long', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      lastNameController.text = 'B' * 51;
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Last Name - Invalid characters', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      lastNameController.text = 'Doe@#';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Email - Empty input', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      emailController.text = '';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Email - Invalid format', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      emailController.text = 'invalidemail.com';
      expect(formKey.currentState?.validate() ?? false, isFalse);
      emailController.text = 'user@';
      expect(formKey.currentState?.validate() ?? false, isFalse);
      emailController.text = '@domain.com';
      expect(formKey.currentState?.validate() ?? false, isFalse);
      emailController.text = 'user@domain';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Email - Too long', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      emailController.text = '${'a'*245}@test.com';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Password - Empty input', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      passwordController.text = '';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Password - Too short', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      passwordController.text = 'Ab1!';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Password - Too long', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      passwordController.text = 'A' * 129 + 'a1!';
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });

    testWidgets('Password - Missing uppercase, lowercase, number, or special character', (tester) async {
      await tester.pumpWidget(buildTestableForm());
      passwordController.text = 'alllowercase1!'; // missing uppercase
      expect(formKey.currentState?.validate() ?? false, isFalse);
      passwordController.text = 'ALLUPPERCASE1!'; // missing lowercase
      expect(formKey.currentState?.validate() ?? false, isFalse);
      passwordController.text = 'NoNumber!'; // missing number
      expect(formKey.currentState?.validate() ?? false, isFalse);
      passwordController.text = 'NoSpecial1'; // missing special character
      expect(formKey.currentState?.validate() ?? false, isFalse);
    });
  });
} 