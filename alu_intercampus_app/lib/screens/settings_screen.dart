import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F4B),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── App Bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white12, height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // ── ACCOUNT ────────────────────────────────────
                    _sectionLabel('ACCOUNT'),
                    const SizedBox(height: 10),
                    _SettingsGroup(
                      items: [
                        _SettingsItem(
                          icon: Icons.manage_accounts_outlined,
                          label: 'Edit profile',
                          onTap: () {},
                        ),
                        _SettingsItem(
                          icon: Icons.language,
                          label: 'Campus & language',
                          onTap: () {},
                          showDivider: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ── PREFERENCES ────────────────────────────────
                    _sectionLabel('PREFERENCES'),
                    const SizedBox(height: 10),
                    _SettingsGroup(
                      items: [
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
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ── PRIVACY ────────────────────────────────────
                    _sectionLabel('PRIVACY'),
                    const SizedBox(height: 10),
                    _SettingsGroup(
                      items: [
                        _SettingsItem(
                          icon: Icons.lock_outline,
                          label: 'Privacy & data',
                          onTap: () {},
                          showDivider: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Sign out ───────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                        label: const Text(
                          'Sign out',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _sectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> items;
  const _SettingsGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A5E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: items,
      ),
    );
  }
}

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
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white70, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white38, size: 20),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            color: Colors.white10,
            indent: 66,
            endIndent: 16,
          ),
      ],
    );
  }
}