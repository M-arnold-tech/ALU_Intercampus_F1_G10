import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          //  Hero image with back + share 
          Stack(
            children: [
              // Cover image
              SizedBox(
                height: 260,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/company-employee-presenting-business-strategy-with-charts-monitor-planning-project-workmates-analyzing-financial-statistics-display-working-together-company-development.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF1E2D55),
                    child: const Center(
                      child: Icon(Icons.image_outlined,
                          color: Colors.white24, size: 56),
                    ),
                  ),
                ),
              ),
              // Back button
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                child: _CircleIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              // Share button
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                right: 16,
                child: _CircleIconButton(
                  icon: Icons.share_outlined,
                  onTap: () {},
                ),
              ),
            ],
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Row(
                    children: const [
                      _TagChip(label: 'Workshops'),
                      SizedBox(width: 8),
                      _TagChip(label: 'Tech'),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Title
                  const Text(
                    'AI for Social Impact Workshop',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  const SizedBox(height: 16),

                  // Info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: const [
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          title: 'Jun 5, 2026',
                          subtitle: '09:00 AM',
                        ),
                        SizedBox(height: 14),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          title: 'Mauritius Campus',
                          subtitle: 'Innovation Lab',
                        ),
                        SizedBox(height: 14),
                        _InfoRow(
                          icon: Icons.people_outline,
                          title: '128 going',
                          subtitle: '12 interested',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'Learn how AI tools can be used to drive social impact in Africa. Hands-on session + group projects.',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.6),
                  ),

                  const SizedBox(height: 16),

                  // Going avatars + counts
                  Row(
                    children: [
                      // Stacked avatars
                      SizedBox(
                        width: 96,
                        height: 34,
                        child: Stack(
                          children: List.generate(3, (i) {
                            return Positioned(
                              left: i * 26.0,
                              child: CircleAvatar(
                                radius: 17,
                                backgroundColor: [
                                  const Color(0xFF4CAF50),
                                  const Color(0xFF2196F3),
                                  const Color(0xFFFF9800),
                                ][i],
                                child: const Icon(Icons.person,
                                    size: 16, color: Colors.white),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('52 going',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13)),
                      const Spacer(),
                      const Text('12 interested',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 0,
                          ),
                          child: const Text('RSVP',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Colors.white, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Interested',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // See all RSVPs
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('See all my RSVPs',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 13)),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Helpers 
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoRow(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white70, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            Text(subtitle,
                style: const TextStyle(
                    color: Colors.white54, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
