import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';
import 'package:alu_intercampus_app/screens/Auth service.dart';
import 'package:alu_intercampus_app/screens/setting screen.dart';
import 'package:alu_intercampus_app/screens/Notification screen.dart';
import 'package:alu_intercampus_app/screens/studygroup screen.dart';
import 'package:alu_intercampus_app/screens/mentorship screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Header ───────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Profile',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsScreen())),
                    child: const Icon(Icons.settings_outlined,
                        color: Colors.white, size: 24),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Profile card ──────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade700,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/young-cute-woman-cap-glasses-posing-outside-showing-thumbs-up-high-quality-photo.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 44,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(AuthService.instance.displayName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),

                    const SizedBox(height: 4),

                    Text(
                        AuthService.instance.email.isNotEmpty
                            ? AuthService.instance.email
                            : 'Kigali Campus . Year 3 . BEL',
                        style: const TextStyle(
                            fontSize: 13, color: Colors.white54)),

                    const SizedBox(height: 16),

                    // Stats row
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _StatCell(value: '23', label: 'EVENTS'),
                          _Divider(),
                          _StatCell(value: '5', label: 'COMMUNITIES'),
                          _Divider(),
                          _StatCell(value: '87', label: 'CONNECTIONS'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Menu items ────────────────────────────────────────
              _MenuItem(
                icon: Icons.article_outlined,
                label: 'My Posts',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.bookmark_outline,
                label: 'Saved',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.school_outlined,
                label: 'Mentorship',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const MentorshipScreen())),
              ),
              _MenuItem(
                icon: Icons.people_outline,
                label: 'Study Groups',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const StudyGroupsScreen())),
              ),
              _MenuItem(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const NotificationsScreen())),
              ),
              _MenuItem(
                icon: Icons.shield_outlined,
                label: 'Account & Privacy',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const SettingsScreen())),
              ),
              _MenuItem(
                icon: Icons.help_outline,
                label: 'Help & Support',
                onTap: () {},
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white54,
                  letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: Colors.white12);
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
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
    );
  }
}