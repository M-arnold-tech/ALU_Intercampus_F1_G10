import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';
import 'package:alu_intercampus_app/screens/Auth service.dart';
import 'package:alu_intercampus_app/screens/eventdetails screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              // ── Header ────────────────────────────────────────────
              Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.cardBackground,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/young-cute-woman-cap-glasses-posing-outside-showing-thumbs-up-high-quality-photo.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          color: Colors.white54,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // We accessed the singleton AuthService here to pull the user's first name,
                      // ensuring the UI felt personalized immediately upon login.
                      Text('Hi, ${AuthService.instance.firstName}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Text('What\'s happening today?',
                          style: TextStyle(
                              fontSize: 13, color: Colors.white54)),
                    ],
                  ),
                  const Spacer(),
                  // Notification bell with badge
                  Stack(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_outlined,
                            color: Colors.white, size: 22),
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Search bar ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.white54, size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Category icons ────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CategoryIcon(icon: Icons.apps, label: 'All', color: Color(0xFFC9A227), active: true),
                  _CategoryIcon(icon: Icons.calendar_today_outlined, label: 'Events', color: Color(0xFF3D5A99)),
                  _CategoryIcon(icon: Icons.menu_book_outlined, label: 'Opportunities', color: Color(0xFF2AA198)),
                  _CategoryIcon(icon: Icons.people_outline, label: 'Clubs', color: Color(0xFF4CAF50)),
                  _CategoryIcon(icon: Icons.school_outlined, label: 'Academics', color: Color(0xFF3D5A99)),
                ],
              ),

              const SizedBox(height: 24),

              // ── Featured ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('see all',
                        style: TextStyle(color: Colors.white54, fontSize: 13)),
                  ),
                ],
              ),

              // Featured card
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EventDetailScreen())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.cardBackground,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cover image
                      Container(
                        height: 180,
                        color: Colors.grey.shade800,
                        child: Image.asset(
                          'assets/images/company-employee-presenting-business-strategy-with-charts-monitor-planning-project-workmates-analyzing-financial-statistics-display-working-together-company-development.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          // We implemented this errorBuilder so that if an image failed to load,
                          // the app showed a placeholder icon instead of crashing the UI.
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFF1E2D55),
                            child: const Center(
                              child: Icon(Icons.image_outlined,
                                  color: Colors.white24, size: 48),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('May 24,2026.Kigali CAMPUS',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white54)),
                            const SizedBox(height: 4),
                            const Text('ALU Entrepreneurship Pitch Night',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const SizedBox(height: 4),
                            const Text(
                                'Showcase your idea, get feedback and connect with mentors',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white54)),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white54),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: const Text('View details',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Latest Opportunities ──────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Latest Opportunities',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('see all',
                        style: TextStyle(color: Colors.white54, fontSize: 13)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // We used this _OpportunityTile helper component to ensure that
              // all items in our list remained visually consistent and easy to update.
              _OpportunityTile(
                imageAsset: 'assets/images/pitching_a_business.jpeg',
                title: 'Sustainable Solution Challenge',
                subtitle: 'Apply by May 20,2026. Mauritius Campus',
                tag: 'COMPETITION',
                tagColor: const Color(0xFF3D5A99),
              ),
              _OpportunityTile(
                imageAsset: 'assets/images/sunrise-bali-jungle.jpg',
                title: 'Campus Ambassador Program',
                subtitle: 'Apply by May 22,2026. All Campus',
                tag: 'OPPORTUNITY',
                tagColor: const Color(0xFF2AA198),
              ),
              _OpportunityTile(
                imageAsset: 'assets/images/The_Most_Common_Mistakes_When_Starting_a_New_Project.jpg',
                title: 'ALU Climate Action week',
                subtitle: 'Apply by May 28,2026. Both Campus',
                tag: 'EVENT',
                tagColor: const Color(0xFF4CAF50),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool active;

  const _CategoryIcon({
    required this.icon,
    required this.label,
    required this.color,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Colors.white70)),
      ],
    );
  }
}

class _OpportunityTile extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;

  const _OpportunityTile({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageAsset,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              // Similar to our main card, we added an error handler here to 
              // preserve layout integrity even if individual assets failed to load.
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                color: Colors.white12,
                child: const Icon(Icons.image_outlined,
                    color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: tagColor.withOpacity(0.5)),
            ),
            child: Text(tag,
                style: TextStyle(
                    color: tagColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}