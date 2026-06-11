import 'package:flutter/material.dart';

// I created this FeedScreen widget to display a dynamic feed for users, allowing them to browse categories, featured events, and opportunities.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

// I implemented this state class to manage the UI state, including selected categories and bottom navigation.
class _FeedScreenState extends State<FeedScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'All';

  // I added this list to store category data, including labels and their corresponding colors for the UI.
  final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'color': const Color(0xFFF5A623)},
    {'label': 'Events', 'color': const Color(0xFF3A5FCD)},
    {'label': 'Opportunities', 'color': const Color(0xFF40C4FF)},
    {'label': 'Clubs', 'color': const Color(0xFF8BC34A)},
    {'label': 'Academics', 'color': const Color(0xFF3D5AFE)},
  ];

  // I included this featured event data to highlight a specific event prominently in the feed.
  final Map<String, dynamic> featuredEvent = {
    'title': 'ALU Entrepreneurship Pitch Night',
    'description': 'Showcase your idea, get feedback and connect with mentors',
    'date': 'May 24, 2026, Kigali CAMPUS',
  };

  // I added this list to display the latest opportunities available for users.
  final List<Map<String, dynamic>> latestOpportunities = [
    {
      'title': 'Sustainable Solution Challenge',
      'deadline': 'Apply by May 20, 2026. Mauritius Campus',
      'tag': 'COMPETITION',
      'tagColor': Color(0xFF3A5FCD),
      'image': 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=120&q=80',
    },
    {
      'title': 'Campus Ambassador Program',
      'deadline': 'Apply by May 22, 2026. All Campus',
      'tag': 'OPPORTUNITY',
      'tagColor': Color(0xFF00897B),
      'image': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=120&q=80',
    },
    {
      'title': 'ALU Climate Action week',
      'deadline': 'Apply by May 28, 2026. Both Campus',
      'tag': 'EVENT',
      'tagColor': Color(0xFF5C6BC0),
      'image': 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=120&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F4B),
      body: Column(
        children: [
          // I designed this header section to display user info, a greeting, and a search bar.
          Container(
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
            color: const Color(0xFF0F1F4B),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // I added this avatar to personalize the user experience.
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white24, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=100&q=80',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi, Aline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "What's happening today?",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // I included this notification icon to allow users to access their notifications.
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: const Icon(Icons.notifications_none, color: Colors.white70, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // I added this search bar to let users search for content in the app.
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2A5E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 14),
                      Icon(Icons.search, color: Colors.white70, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // I used this scrollable section to display all the dynamic content like categories, featured events, and opportunities.
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // I implemented this horizontal list of category circles to let users filter content by category.
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = cat['label'] == selectedCategory;
                        return GestureDetector(
                          onTap: () => setState(() => selectedCategory = cat['label']),
                          child: Container(
                            width: 72,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cat['color'] as Color,
                                    border: isSelected
                                        ? Border.all(color: Colors.white, width: 2.5)
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  cat['label'] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.white70,
                                    fontSize: 11,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // I added this featured section header to introduce the highlighted event.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // I created this featured card to showcase a prominent event with an image and details.
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2A5E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // I added this image to visually represent the featured event.
                        SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFF263A7A),
                              child: const Icon(Icons.image, color: Colors.white38, size: 60),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                featuredEvent['date'] as String,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.55),
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                featuredEvent['title'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                featuredEvent['description'] as String,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.65),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 14),
                              // I added this button to allow users to view more details about the featured event.
                              SizedBox(
                                width: 130,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF1A237E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  child: const Text(
                                    'View details',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // I added this latest opportunities section header to introduce the list of opportunities.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Opportunities',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // I used this to render each opportunity card dynamically from the list.
                  ...latestOpportunities.map((opp) => _buildOpportunityCard(opp)),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),

      // I implemented this bottom navigation bar to allow users to switch between different app sections.
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F1F4B),
          border: Border(
            top: BorderSide(color: const Color(0xFFF5A623).withOpacity(0.6), width: 1.5),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                _navItem(icon: Icons.home, label: 'Home', index: 0),
                _navItem(icon: Icons.explore_outlined, label: 'Explore', index: 1),
                // I added this center FAB to allow users to create new content.
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5A623),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ),
                _navItem(icon: Icons.chat_bubble_outline, label: 'Chats', index: 3),
                _navItem(icon: Icons.person_outline, label: 'Profile', index: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // I created this helper method to build each bottom navigation item dynamically.
  Widget _navItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected ? Colors.white : Colors.white38,
                size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white38,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // I implemented this helper method to build each opportunity card dynamically.
  Widget _buildOpportunityCard(Map<String, dynamic> opp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A5E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // I added this thumbnail to visually represent each opportunity.
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              opp['image'] as String,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: const Color(0xFF263A7A),
                child: const Icon(Icons.image, color: Colors.white38),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // I included this text content to display opportunity details like title and deadline.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opp['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  opp['deadline'] as String,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // I added this tag button to allow users to filter by opportunity type.
          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Filter by: ${opp['tag']}')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A237E),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: Text(
                opp['tag'] as String,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}