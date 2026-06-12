import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';
import 'package:alu_intercampus_app/screens/eventdetails screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Events', 'Opportunities', 'Clubs'];

  final List<Map<String, dynamic>> _recommended = [
    {
      'image': 'assets/images/pitching_a_business.jpeg',
      'title': 'Sustainable Solution Challenge',
      'subtitle': 'Apply by May 20,2026. Mauritius Campus',
      'tag': 'COMPETITION',
      'tagColor': Color(0xFF3D5A99),
    },
    {
      'image': 'assets/images/The_Most_Common_Mistakes_When_Starting_a_New_Project.jpg',
      'title': 'Campus Ambassador Program',
      'subtitle': 'Apply by May 22,2026. All Campus',
      'tag': 'OPPORTUNITY',
      'tagColor': Color(0xFF2AA198),
    },
    {
      'image': 'assets/images/sunrise-bali-jungle.jpg',
      'title': 'ALU Climate Action week',
      'subtitle': 'Apply by May 28,2026. Both Campus',
      'tag': 'EVENT',
      'tagColor': Color(0xFF4CAF50),
    },
    {
      'image': 'assets/images/designing_workshopa.jpg',
      'title': 'Build Your First MVP Workshop',
      'subtitle': 'Apply by Jun 02,2026. All Campus',
      'tag': 'EVENT',
      'tagColor': Color(0xFF4CAF50),
    },
  ];

  final List<Map<String, String>> _trending = [
    {'image': 'assets/images/trash_box.jpg', 'title': 'Community Clean Up', 'date': 'May 18, 2026'},
    {'image': 'assets/images/company-employee-presenting-business-strategy-with-charts-monitor-planning-project-workmates-analyzing-financial-statistics-display-working-together-company-development.jpg', 'title': 'AI for social Impact Workshops', 'date': 'Jun 5,2026'},
    {'image': 'assets/images/designing_workshopa.jpg', 'title': 'Design thinking Bootcamp', 'date': 'May 30, 2026'},
    {'image': 'assets/images/pitching_a_business.jpeg', 'title': 'Pitch Night', 'date': 'May 24,2026'},
  ];

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

              // ── Header ─────────────────────────────────────────────
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text('Explore',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),

              const SizedBox(height: 16),

              // ── Search ─────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.white54, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Filter chips ───────────────────────────────────────
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_filters.length, (i) {
                    final isSelected = _selectedFilter == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _filters[i],
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.background
                                : Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              // ── Recommended for you ────────────────────────────────
              const Text('RECOMMENDED FOR YOU',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                      letterSpacing: 0.8)),

              const SizedBox(height: 12),

              ..._recommended.map((item) => _RecommendedTile(item: item)),

              const SizedBox(height: 24),

              // ── Trending Events ────────────────────────────────────
              const Text('TRENDING EVENTS',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                      letterSpacing: 0.8)),

              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemCount: _trending.length,
                itemBuilder: (_, i) {
                  final item = _trending[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EventDetailScreen())),
                    child: _TrendingCard(item: item),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _RecommendedTile extends StatelessWidget {
  final Map<String, dynamic> item;
  const _RecommendedTile({required this.item});

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
              item['image'] as String,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                color: Colors.white12,
                child: const Icon(Icons.image_outlined, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'] as String,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text(item['subtitle'] as String,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (item['tagColor'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: (item['tagColor'] as Color).withOpacity(0.5)),
            ),
            child: Text(item['tag'] as String,
                style: TextStyle(
                    color: item['tagColor'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  final Map<String, String> item;
  const _TrendingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            item['image']!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.cardBackground,
              child: const Icon(Icons.image_outlined,
                  color: Colors.white24, size: 36),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title']!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                const SizedBox(height: 2),
                Text(item['date']!,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}