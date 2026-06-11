import 'package:flutter/material.dart';
import 'feed_screen.dart';

// I created this AuthScreen widget to handle user authentication, including sign-in and sign-up flows.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

// I implemented this state class to manage authentication logic and UI state.
class _AuthScreenState extends State<AuthScreen> {
  // I added these controllers to capture user input in the sign-up and sign-in dialogs.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // I used this mock storage to simulate user data for demo purposes.
  final Map<String, Map<String, String>> _users = {};

  // I created this method to display a sign-in dialog for users to log in with their ALU account.
  void _showSignInDialog() {
    String? emailError;
    String? passwordError;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1A2A5E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Sign in with ALU Account',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // I added this text field to capture the user's ALU email.
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ALU Email (@alustudent.com)',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    errorText: emailError,
                    errorStyle: const TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // I added this text field to capture the user's password.
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    errorText: passwordError,
                    errorStyle: const TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              // I added this cancel button to allow users to exit the sign-in dialog.
              TextButton(
                onPressed: () {
                  _emailController.clear();
                  _passwordController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
              ),
              // I added this sign-in button to validate user credentials and log them in.
              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text;
                  String? eErr;
                  String? pErr;

                  if (email.isEmpty) {
                    eErr = 'Please enter your email';
                  } else if (!email.endsWith('@alustudent.com')) {
                    eErr = 'Must use @alustudent.com email';
                  }

                  if (password.isEmpty) {
                    pErr = 'Please enter your password';
                  }

                  if (eErr != null || pErr != null) {
                    setDialogState(() {
                      emailError = eErr;
                      passwordError = pErr;
                    });
                    return;
                  }

                  if (_users.containsKey(email) && _users[email]!['password'] == password) {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedScreen()),
                    );
                  } else {
                    setDialogState(() {
                      passwordError = 'Invalid email or password. Sign up first.';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Sign In'),
              ),
            ],
          );
        });
      },
    );
  }

  // I created this method to display a create account dialog for new users to register.
  void _showCreateAccountDialog() {
    String? emailError;
    String? passwordError;
    String? nameError;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1A2A5E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Create Account',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // I added this text field to capture the user's full name.
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    errorText: nameError,
                    errorStyle: const TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // I added this text field to capture the user's ALU email.
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ALU Email (@alustudent.com)',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    errorText: emailError,
                    errorStyle: const TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // I added this text field to capture the user's password.
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password (min 6 chars)',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    errorText: passwordError,
                    errorStyle: const TextStyle(color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              // I added this cancel button to allow users to exit the create account dialog.
              TextButton(
                onPressed: () {
                  _emailController.clear();
                  _passwordController.clear();
                  _nameController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
              ),
              // I added this create button to register a new user account.
              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text;
                  String name = _nameController.text.trim();
                  String? eErr;
                  String? pErr;
                  String? nErr;

                  if (name.isEmpty) nErr = 'Please enter your name';
                  if (email.isEmpty) {
                    eErr = 'Please enter your email';
                  } else if (!email.endsWith('@alustudent.com')) {
                    eErr = 'Must use @alustudent.com email';
                  } else if (_users.containsKey(email)) {
                    eErr = 'Account already exists. Please login.';
                  }
                  if (password.isEmpty) {
                    pErr = 'Please enter your password';
                  } else if (password.length < 6) {
                    pErr = 'Password must be at least 6 characters';
                  }

                  if (eErr != null || pErr != null || nErr != null) {
                    setDialogState(() {
                      emailError = eErr;
                      passwordError = pErr;
                      nameError = nErr;
                    });
                    return;
                  }

                  _users[email] = {'password': password, 'name': name};
                  _emailController.clear();
                  _passwordController.clear();
                  _nameController.clear();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created! Please sign in.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Create'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F4B),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // I added this title section to display the app name.
                const Text(
                  'ALU',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const Text(
                  'Intercampus',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Connect',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF5A623),
                  ),
                ),

                const Spacer(flex: 2),

                // I added this sign-in button to open the sign-in dialog.
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _showSignInDialog,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.12),
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.3)),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      'Sign in with ALU Account',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // I added this text to separate the sign-in button from social login options.
                const Text(
                  'or continue with',
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),

                const SizedBox(height: 24),

                // I added these social login buttons for Google and Apple.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      onTap: () {},
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/480px-Google_%22G%22_logo.svg.png',
                        width: 28,
                        height: 28,
                        errorBuilder: (_, __, ___) => const Icon(Icons.g_mobiledata, size: 32, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(width: 20),
                    _socialButton(
                      onTap: () {},
                      child: const Icon(Icons.apple, size: 30, color: Colors.black87),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // I added this link to allow new users to create an account.
                GestureDetector(
                  onTap: _showCreateAccountDialog,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'New here?',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextSpan(
                          text: 'Create account',
                          style: TextStyle(
                            color: Color(0xFFF5A623),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // I created this helper method to build social login buttons dynamically.
  Widget _socialButton({required VoidCallback onTap, required Widget child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: child),
      ),
    );
  }
}