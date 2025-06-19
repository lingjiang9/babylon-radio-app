import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navigate to home page
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/App Name
                  const Icon(Icons.flutter_dash, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    'Babylon Radio',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 48),

                  // Login Form
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // First Name Field
                          TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              prefixIcon: Icon(Icons.person_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
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
                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                                return 'First name can only contain letters and spaces';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Last Name Field
                          TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              prefixIcon: Icon(Icons.person_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
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
                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                                return 'Last name can only contain letters and spaces';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                            validator: (value) {
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
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
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
                              if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]').hasMatch(value)) {
                                return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Login Button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF667eea),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),

                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              TextButton(
                                onPressed: () {
                                  // Navigate to sign up page
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
