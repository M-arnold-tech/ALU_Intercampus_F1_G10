import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';

// We defined MentorshipScreen as a StatefulWidget to manage the local state
// of the mentorship list, such as the refresh status and the set of requested mentors.
class MentorshipScreen extends StatefulWidget {
  const MentorshipScreen({super.key});

  @override
  State<MentorshipScreen> createState() => _MentorshipScreenState();
}

class _MentorshipScreenState extends State<MentorshipScreen> {
  // _refreshing tracks the loading state during the simulated refresh action.
  bool _refreshing = false;

  // We defined a private _Mentor model class at the bottom to structure our data,
  // making it easier to map over the list to generate UI components.
  final List<_Mentor> _mentors = [
    _Mentor(
      name: 'Dr. Amani Okafor',
      role: 'Founder - GreenTech Africa',
      campus: 'Kigali',
      match: 94,
      tags: ['Entrepreneurship', 'ClimateTech'],
    ),
    _Mentor(
      name: 'Sophia Mwangi',
      role: 'Senior PM - Andela',
      campus: 'Mauritius',
      match: 88,
      tags: ['Product', 'Tech'],
    ),
    _Mentor(
      name: 'Kwame Asante',
      role: 'VC Analyst - Future Africa',
      campus: 'Kigali',
      match: 81,
      tags: ['Venture', 'Finance'],
    ),
    _Mentor(
      name: 'Liora Bekele',
      role: 'Design Lead - Flutterwave',
      campus: 'Mauritius',
      match: 76,
      tags: ['Design', 'UX'],
    ),
  ];

  // Using a Set for requested mentors ensures efficient O(1) lookups 
  // to check if a mentor has already been requested, preventing UI bugs.
  final Set<String> _requested = {};

  // This method simulates a network request to fetch new AI-matched mentors.
  Future<void> _refresh() async {
    setState(() => _refreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _refreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom App Bar section for consistent navigation and title display.
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Mentorship',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text('AI-matched alumni mentors',
                          style: TextStyle(
                              fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Colors.white.withOpacity(0.08)),

            // The main list area is wrapped in a SingleChildScrollView
            // to ensure it handles overflow gracefully on smaller screens.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Smart matching banner: Provides immediate value proposition.
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white12,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.hub_outlined,
                                color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Smart matching',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                Text(
                                    'Based on your interests, campus & goals.',
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Refresh button with conditional loading state.
                          GestureDetector(
                            onTap: _refresh,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: _refreshing
                                  ? const SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white))
                                  : const Text('Refresh',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Section header for the list of matches.
                    const Text('TOP MATCHES',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),

                    const SizedBox(height: 12),

                    // Mapping over the list to generate an _MentorCard for every mentor.
                    ..._mentors.map((m) => _MentorCard(
                          mentor: m,
                          isRequested: _requested.contains(m.name),
                          onRequest: () => setState(
                              () => _requested.add(m.name)),
                        )),
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

// Data model representing an alumni mentor's profile information.
class _Mentor {
  final String name;
  final String role;
  final String campus;
  final int match;
  final List<String> tags;

  const _Mentor({
    required this.name,
    required this.role,
    required this.campus,
    required this.match,
    required this.tags,
  });
}

// Reusable card widget for displaying individual mentor details.
class _MentorCard extends StatelessWidget {
  final _Mentor mentor;
  final bool isRequested;
  final VoidCallback onRequest;

  const _MentorCard({
    required this.mentor,
    required this.isRequested,
    required this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mentor header: Shows image, name, role, and match percentage.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.grey.shade700,
                child: Text(
                  mentor.name.substring(0, 1),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mentor.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(mentor.role,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12)),
                    Text(mentor.campus,
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              // Match badge: Visually highlights the compatibility score.
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('${mentor.match}% match',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Interest tags: Displayed using a Wrap to handle different tag lengths.
          Wrap(
            spacing: 8,
            children: mentor.tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(t,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ))
                .toList(),
          ),

          const SizedBox(height: 14),

          // Action buttons: Allows the user to request a mentor or view their full profile.
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: isRequested ? null : onRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isRequested ? Colors.white24 : Colors.white,
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: Colors.white24,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      isRequested ? 'Requested' : 'Request mentor',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isRequested
                              ? Colors.white54
                              : Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Colors.white38, width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('View profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
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