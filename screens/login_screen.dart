import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';
import 'package:alu_intercampus_app/screens/Auth service.dart';
import 'package:alu_intercampus_app/onboarding/onboarding_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Regex validators
  static final RegExp _aluEmailRegex =
      RegExp(r'^[a-zA-Z0-9._%+\-]+@alustudent\.com$');
  static final RegExp _gmailRegex =
      RegExp(r'^[a-zA-Z0-9._%+\-]+@gmail\.com$');

  void _showEmailDialog({required bool isAlu}) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscure = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    isAlu
                        ? 'Sign in with ALU Account'
                        : 'Sign in with Google',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    isAlu
                        ? 'Use your @.alustudent.com email'
                        : 'Use your @gmail.com email',
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 13),
                  ),

                  const SizedBox(height: 20),

                  // Email field
                  TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: isAlu
                          ? 'you@campus.alustudent.com'
                          : 'you@gmail.com',
                      hintStyle: const TextStyle(
                          color: Colors.white38, fontSize: 14),
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: Colors.white38),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(
                          color: Color(0xFFFF6B6B), fontSize: 12),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B), width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.gold, width: 1.5),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (isAlu && !_aluEmailRegex.hasMatch(val.trim())) {
                        return 'Email must end with .alustudent.com\n(e.g. name@campus.alustudent.com)';
                      }
                      if (!isAlu && !_gmailRegex.hasMatch(val.trim())) {
                        return 'Email must be a valid @gmail.com address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  TextFormField(
                    obscureText: obscure == false ? true : false,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          color: Colors.white38, fontSize: 14),
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Colors.white38),
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            setModalState(() => obscure = !obscure),
                        child: Icon(
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white38,
                          size: 20,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.gold, width: 1.5),
                      ),
                      errorStyle: const TextStyle(
                          color: Color(0xFFFF6B6B), fontSize: 12),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B), width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B), width: 1.5),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (val.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text('Forgot password?',
                          style: TextStyle(
                              color: AppColors.gold, fontSize: 13)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // ── Store user info globally ──────────────
                          AuthService.instance
                              .signIn(controller.text.trim());
                          Navigator.pop(ctx);
                          _goToOnboarding();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Continue',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
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

  void _goToOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingController()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // ── App title ──────────────────────────────────────────
              const Text(
                'ALU',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              const Text(
                'Intercampus',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const Text(
                'Connect',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                  height: 1.2,
                ),
              ),

              const Spacer(flex: 2),

              // ── Sign in with ALU Account ───────────────────────────
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => _showEmailDialog(isAlu: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8EAF0),
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign in with ALU Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── or continue with ───────────────────────────────────
              const Text(
                'or continue with',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 24),

              // ── Social buttons ─────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google — triggers Gmail validation
                  _SocialButton(
                    onTap: () => _showEmailDialog(isAlu: false),
                    child: const _GoogleLogo(),
                  ),
                  const SizedBox(width: 20),
                  // Apple — goes straight through (no email check needed)
                  _SocialButton(
                    onTap: _goToOnboarding,
                    child: const Icon(Icons.apple,
                        color: Colors.black, size: 32),
                  ),
                ],
              ),

              const Spacer(flex: 3),

              // ── New here? Create account ───────────────────────────
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: GestureDetector(
                  onTap: () => _showEmailDialog(isAlu: true),
                  child: RichText(
                    text: const TextSpan(
                      text: 'New here? ',
                      style:
                          TextStyle(color: Colors.white70, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Create account',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _SocialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4285F4),
      ),
    );
  }
}