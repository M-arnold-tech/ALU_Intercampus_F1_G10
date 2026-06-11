import 'package:flutter/material.dart';

class MentorshipScreen extends StatelessWidget {
  const MentorshipScreen({super.key});

  final List<Map<String, dynamic>> mentors = const [
    {
      'name': 'Dr. Amani Okafor',
      'role': 'Founder · GreenTech Africa',
      'location': 'Kigali',
      'match': '94% match',
      'tags': ['Entrepreneurship', 'ClimateTech'],
      'image': 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=120&q=80',
    },
    {
      'name': 'Sophia Mwangi',
      'role': 'Senior PM · Andela',
      'location': 'Mauritius',
      'match': '88% match',
      'tags': ['Product', 'Tech'],
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&q=80',
    },
    {
      'name': 'Kwame Asante',
      'role': 'VC Analyst · Future Africa',
      'location': 'Kigali',
      'match': '81% match',
      'tags': ['Venture', 'Finance'],
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=120&q=80',
    },
    {
      'name': 'Liora Bekele',
      'role': 'Design Lead · Flutterwave',
      'location': 'Mauritius',
      'match': '76% match',
      'tags': ['Design', 'UX'],
      'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=120&q=80',
    },
  ];

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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mentorship',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'AI-matched alumni mentors',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),
                    ],
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
                    const SizedBox(height: 8),

                    // ── Smart Matching Banner ──────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2A5E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.12),
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Smart matching',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Based on your interests, campus & goals.',
                                  style: TextStyle(color: Colors.white60, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Refresh button - WHITE BACKGROUND
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1A237E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            ),
                            child: const Text('Refresh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── TOP MATCHES label ──────────────────────────
                    const Text(
                      'TOP MATCHES',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Mentor cards ───────────────────────────────
                    ...mentors.map((m) => _MentorCard(mentor: m)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MentorCard extends StatelessWidget {
  final Map<String, dynamic> mentor;
  const _MentorCard({required this.mentor});

  @override
  Widget build(BuildContext context) {
    final tags = mentor['tags'] as List<String>;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A5E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar + info + match badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  mentor['image'] as String,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: const Color(0xFF263A7A),
                    child: const Icon(Icons.person, color: Colors.white38),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mentor['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      mentor['role'] as String,
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                    Text(
                      mentor['location'] as String,
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Match badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF263A7A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  mentor['match'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Tags
          Wrap(
            spacing: 8,
            children: tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 14),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A237E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Request mentor', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF263A7A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(color: Colors.white24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'View profile',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}