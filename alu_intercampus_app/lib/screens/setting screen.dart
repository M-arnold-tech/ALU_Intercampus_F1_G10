import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';
import 'package:alu_intercampus_app/screens/login_screen.dart';

// SettingsScreen provides a structured UI for user management, app preferences,
// and privacy settings, allowing users to control their account state.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom App Bar section for consistent navigation.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Text('Settings',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),

            // Main scrollable area containing all settings grouped by category.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // ACCOUNT section handles profile and campus-specific configurations.
                    _SectionLabel('ACCOUNT'),
                    _SettingsGroup(items: [
                      _SettingsItem(
                        icon: Icons.manage_accounts_outlined,
                        label: 'Edit profile',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.language_outlined,
                        label: 'Campus & language',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ]),

                    const SizedBox(height: 20),

                    // PREFERENCES section for visual and notification customizations.
                    _SectionLabel('PREFERENCES'),
                    _SettingsGroup(items: [
                      _SettingsItem(
                        icon: Icons.notifications_outlined,
                        label: 'Notifications',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.dark_mode_outlined,
                        label: 'Appearance',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ]),

                    const SizedBox(height: 20),

                    // PRIVACY section for sensitive data handling.
                    _SectionLabel('PRIVACY'),
                    _SettingsGroup(items: [
                      _SettingsItem(
                        icon: Icons.lock_outline,
                        label: 'Privacy & data',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ]),

                    const SizedBox(height: 24),

                    // Logout action button: Destructive action styled clearly to differentiate from navigation.
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton.icon(
                        onPressed: () => _confirmSignOut(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xFFE57373), width: 1.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.logout,
                            color: Color(0xFFE57373), size: 20),
                        label: const Text('Sign out',
                            style: TextStyle(
                                color: Color(0xFFE57373),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Confirmation dialog to prevent accidental sign-out.
  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Sign out',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to sign out?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              // Sign out logic: Pop the dialog and clear the entire navigation stack
              // to ensure the user cannot return to the settings screen after signing out.
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            child: const Text('Sign out',
                style: TextStyle(color: Color(0xFFE57373))),
          ),
        ],
      ),
    );
  }
}

// Reusable label component for section headers.
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1)),
    );
  }
}

// Container wrapper to visually group related settings items together.
class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> items;
  const _SettingsGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }
}

// Individual settings row with icon, label, and navigation arrow.
class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white70, size: 20),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15)),
                ),
                const Icon(Icons.chevron_right,
                    color: Colors.white38, size: 20),
              ],
            ),
          ),
        ),
        // Conditional divider for list styling.
        if (showDivider)
          Divider(
              height: 1,
              color: Colors.white.withOpacity(0.08),
              indent: 50),
      ],
    );
  }
}