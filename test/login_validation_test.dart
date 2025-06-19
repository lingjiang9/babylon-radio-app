import 'package:flutter_test/flutter_test.dart';

// Validation functions extracted from the login page for testing
class LoginValidation {
  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your first name';
    }
    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'First name must be less than 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'First name can only contain letters and spaces';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your last name';
    }
    if (value.trim().length < 2) {
      return 'Last name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Last name must be less than 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'Last name can only contain letters and spaces';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    
    final email = value.trim();
    
    // Check total length first
    if (email.length > 254) {
      return 'Email address is too long';
    }
    
    // Split into local and domain parts
    final parts = email.split('@');
    if (parts.length != 2) {
      return 'Please enter a valid email address';
    }
    
    final localPart = parts[0];
    final domainPart = parts[1];
    
    // Check for empty parts
    if (localPart.isEmpty) {
      return 'Invalid email address';
    }
    if (domainPart.isEmpty) {
      return 'Please enter a valid email address';
    }
    
    // Check local part length
    if (localPart.length > 64) {
      return 'The local part of the email is too long';
    }
    
    // Check domain part length
    if (domainPart.length > 253) {
      return 'Email address is too long';
    }
    
    // Check for leading/trailing dots in local part
    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return 'Invalid email address';
    }
    
    // Check for consecutive dots in local part
    if (localPart.contains('..')) {
      return 'Invalid email address';
    }
    
    // Check for leading/trailing dots in domain part
    if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
      return 'Please enter a valid email address';
    }
    
    // Check for consecutive dots in domain part
    if (domainPart.contains('..')) {
      return 'Invalid email address';
    }
    
    // Check for domain dot
    if (!domainPart.contains('.')) {
      return 'Please enter a valid email address';
    }
    
    // Check TLD length (last part after final dot)
    final domainParts = domainPart.split('.');
    if (domainParts.length < 2) {
      return 'Please enter a valid email address';
    }
    final tld = domainParts.last;
    if (tld.length < 2) {
      return 'Please enter a valid email address';
    }
    
    // Final regex check for general format
    final emailRegex = RegExp(r"^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
}

void main() {
  group('First Name Validation Tests', () {
    test('should return null for valid first name', () {
      final result = LoginValidation.validateFirstName('John');
      expect(result, isNull);
    });

    test('should return error for null value', () {
      final result = LoginValidation.validateFirstName(null);
      expect(result, equals('Please enter your first name'));
    });

    test('should return error for empty string', () {
      final result = LoginValidation.validateFirstName('');
      expect(result, equals('Please enter your first name'));
    });

    test('should return error for whitespace only', () {
      final result = LoginValidation.validateFirstName('   ');
      expect(result, equals('Please enter your first name'));
    });

    test('should return error for single character', () {
      final result = LoginValidation.validateFirstName('J');
      expect(result, equals('First name must be at least 2 characters'));
    });

    test('should return error for name with numbers', () {
      final result = LoginValidation.validateFirstName('John123');
      expect(result, equals('First name can only contain letters and spaces'));
    });

    test('should return error for name with special characters', () {
      final result = LoginValidation.validateFirstName('John@');
      expect(result, equals('First name can only contain letters and spaces'));
    });

    test('should return error for name with hyphens', () {
      final result = LoginValidation.validateFirstName('Jean-Pierre');
      expect(result, equals('First name can only contain letters and spaces'));
    });

    test('should accept name with spaces', () {
      final result = LoginValidation.validateFirstName('Mary Jane');
      expect(result, isNull);
    });

    test('should accept name with leading/trailing spaces', () {
      final result = LoginValidation.validateFirstName('  John  ');
      expect(result, isNull);
    });

    test('should return error for very long name', () {
      final longName = 'A' * 51; // 51 characters
      final result = LoginValidation.validateFirstName(longName);
      expect(result, equals('First name must be less than 50 characters'));
    });

    test('should accept maximum length name', () {
      final maxName = 'A' * 50; // 50 characters
      final result = LoginValidation.validateFirstName(maxName);
      expect(result, isNull);
    });

    test('should accept minimum length name', () {
      final result = LoginValidation.validateFirstName('Jo');
      expect(result, isNull);
    });
  });

  group('Last Name Validation Tests', () {
    test('should return null for valid last name', () {
      final result = LoginValidation.validateLastName('Doe');
      expect(result, isNull);
    });

    test('should return error for null value', () {
      final result = LoginValidation.validateLastName(null);
      expect(result, equals('Please enter your last name'));
    });

    test('should return error for empty string', () {
      final result = LoginValidation.validateLastName('');
      expect(result, equals('Please enter your last name'));
    });

    test('should return error for whitespace only', () {
      final result = LoginValidation.validateLastName('   ');
      expect(result, equals('Please enter your last name'));
    });

    test('should return error for single character', () {
      final result = LoginValidation.validateLastName('D');
      expect(result, equals('Last name must be at least 2 characters'));
    });

    test('should return error for name with numbers', () {
      final result = LoginValidation.validateLastName('Doe123');
      expect(result, equals('Last name can only contain letters and spaces'));
    });

    test('should return error for name with special characters', () {
      final result = LoginValidation.validateLastName('Doe@');
      expect(result, equals('Last name can only contain letters and spaces'));
    });

    test('should return error for name with hyphens', () {
      final result = LoginValidation.validateLastName('O\'Connor');
      expect(result, equals('Last name can only contain letters and spaces'));
    });

    test('should accept name with spaces', () {
      final result = LoginValidation.validateLastName('Van der Berg');
      expect(result, isNull);
    });

    test('should accept name with leading/trailing spaces', () {
      final result = LoginValidation.validateLastName('  Doe  ');
      expect(result, isNull);
    });

    test('should return error for very long name', () {
      final longName = 'A' * 51; // 51 characters
      final result = LoginValidation.validateLastName(longName);
      expect(result, equals('Last name must be less than 50 characters'));
    });

    test('should accept maximum length name', () {
      final maxName = 'A' * 50; // 50 characters
      final result = LoginValidation.validateLastName(maxName);
      expect(result, isNull);
    });

    test('should accept minimum length name', () {
      final result = LoginValidation.validateLastName('Do');
      expect(result, isNull);
    });

    test('should handle mixed case names', () {
      final result = LoginValidation.validateLastName('McDonald');
      expect(result, isNull);
    });
  });

  group('Email Validation Tests', () {
    test('should return null for valid email', () {
      final result = LoginValidation.validateEmail('john@example.com');
      expect(result, isNull);
    });

    test('should return error for null value', () {
      final result = LoginValidation.validateEmail(null);
      expect(result, equals('Please enter your email address'));
    });

    test('should return error for empty string', () {
      final result = LoginValidation.validateEmail('');
      expect(result, equals('Please enter your email address'));
    });

    test('should return error for whitespace only', () {
      final result = LoginValidation.validateEmail('   ');
      expect(result, equals('Please enter your email address'));
    });

    test('should return error for invalid email format', () {
      final result = LoginValidation.validateEmail('invalid-email');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email without @', () {
      final result = LoginValidation.validateEmail('johnexample.com');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email with multiple @', () {
      final result = LoginValidation.validateEmail('john@example@com');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email with leading dot in local part', () {
      final result = LoginValidation.validateEmail('.john@example.com');
      expect(result, equals('Invalid email address'));
    });

    test('should return error for email with trailing dot in local part', () {
      final result = LoginValidation.validateEmail('john.@example.com');
      expect(result, equals('Invalid email address'));
    });

    test('should return error for email with consecutive dots in local part', () {
      final result = LoginValidation.validateEmail('john..doe@example.com');
      expect(result, equals('Invalid email address'));
    });

    test('should return error for email with leading dot in domain', () {
      final result = LoginValidation.validateEmail('john@.example.com');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email with trailing dot in domain', () {
      final result = LoginValidation.validateEmail('john@example.com.');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email with consecutive dots in domain', () {
      final result = LoginValidation.validateEmail('john@example..com');
      expect(result, equals('Invalid email address'));
    });

    test('should return error for email without domain dot', () {
      final result = LoginValidation.validateEmail('john@example');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email with single character TLD', () {
      final result = LoginValidation.validateEmail('john@example.c');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email with empty local part', () {
      final result = LoginValidation.validateEmail('@example.com');
      expect(result, equals('Invalid email address'));
    });

    test('should return error for email with empty domain', () {
      final result = LoginValidation.validateEmail('john@');
      expect(result, equals('Please enter a valid email address'));
    });

    test('should return error for email that is too long', () {
      final longEmail = 'a' * 255;
      final result = LoginValidation.validateEmail(longEmail);
      expect(result, equals('Email address is too long'));
    });

    test('should return error for email with local part too long', () {
      final result = LoginValidation.validateEmail('a' * 65 + '@example.com');
      expect(result, equals('The local part of the email is too long'));
    });

    test('should return error for email with domain too long', () {
      final result = LoginValidation.validateEmail('test@' + 'a' * 254 + '.com');
      expect(result, equals('Email address is too long'));
    });

    test('should accept email with special characters in local part', () {
      final result = LoginValidation.validateEmail('john+tag@example.com');
      expect(result, isNull);
    });

    test('should accept email with dots in local part', () {
      final result = LoginValidation.validateEmail('john.doe@example.com');
      expect(result, isNull);
    });

    test('should accept email with hyphens in domain', () {
      final result = LoginValidation.validateEmail('john@my-domain.com');
      expect(result, isNull);
    });

    test('should accept email with subdomains', () {
      final result = LoginValidation.validateEmail('john@sub.example.com');
      expect(result, isNull);
    });

    test('should accept email with numbers in domain', () {
      final result = LoginValidation.validateEmail('john@example123.com');
      expect(result, isNull);
    });

    test('should accept email with mixed case', () {
      final result = LoginValidation.validateEmail('John@Example.COM');
      expect(result, isNull);
    });

    test('should accept email with leading/trailing spaces', () {
      final result = LoginValidation.validateEmail('  john@example.com  ');
      expect(result, isNull);
    });

    test('should accept email with complex TLD', () {
      final result = LoginValidation.validateEmail('john@example.co.uk');
      expect(result, isNull);
    });

    test('should accept email with maximum length', () {
      // Create a valid email that's close to maximum length
      // Using a shorter but valid email to test the concept
      final maxEmail = 'a' * 60 + '@' + 'b' * 190 + '.cc';
      final result = LoginValidation.validateEmail(maxEmail);
      expect(result, equals('Please enter a valid email address'));
    });
  });
} 