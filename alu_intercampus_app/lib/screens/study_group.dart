import 'package:flutter/material.dart';

class StudyGroupsPage extends StatefulWidget {
  const StudyGroupsPage({super.key});

  @override
  State<StudyGroupsPage> createState() => _StudyGroupsPageState();
}

class _StudyGroupsPageState extends State<StudyGroupsPage> {
  final List<StudyGroup> _groups = [
    StudyGroup(
      name: 'Quantitative Methods',
      host: 'Brian K.',
      day: 'Tue',
      time: '6:00 PM',
      location: 'Library Room 3',
      totalSeats: 10,
      filledSeats: 6,
      availableSeats: 4,
      isJoined: false,
    ),
    StudyGroup(
      name: 'Entrepreneurial Leadership',
      host: 'Aline U.',
      day: 'Wed',
      time: '7:30 PM',
      location: 'Online · Zoom',
      totalSeats: 10,
      filledSeats: 8,
      availableSeats: 2,
      isJoined: false,
    ),
    StudyGroup(
      name: 'Data Structures',
      host: 'Tinashe M.',
      day: 'Thu',
      time: '5:00 PM',
      location: 'Tech Lab',
      totalSeats: 10,
      filledSeats: 2,
      availableSeats: 8,
      isJoined: false,
    ),
    StudyGroup(
      name: 'Public Speaking Lab',
      host: 'Mariam S.',
      day: 'Fri',
      time: '4:00 PM',
      location: 'Auditorium',
      totalSeats: 10,
      filledSeats: 4,
      availableSeats: 6,
      isJoined: false,
    ),
  ];

  void _joinGroup(int index) {
    setState(() {
      final group = _groups[index];
      if (!group.isJoined && group.availableSeats > 0) {
        group.isJoined = true;
        group.filledSeats += 1;
        group.availableSeats -= 1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You joined ${_groups[index].name}!'),
        backgroundColor: const Color(0xFF238636),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _createGroup() {
    // Navigate to create group page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Create group — coming soon!'),
        backgroundColor: Color(0xFF1E2530),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Study Groups',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Learn together, ship together',
              style: TextStyle(
                color: Color(0xFF8B949E),
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: FloatingActionButton.small(
              onPressed: _createGroup,
              backgroundColor: Colors.white,
              elevation: 0,
              child: const Icon(Icons.add, color: Colors.black, size: 22),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _StudyGroupCard(
              group: _groups[index],
              onJoin: () => _joinGroup(index),
            ),
          );
        },
      ),
    );
  }
}

class _StudyGroupCard extends StatelessWidget {
  final StudyGroup group;
  final VoidCallback onJoin;

  const _StudyGroupCard({
    required this.group,
    required this.onJoin,
  });

  Color get _seatBadgeColor {
    if (group.availableSeats == 0) return const Color(0xFFDA3633);
    if (group.availableSeats <= 2) return const Color(0xFFD29922);
    return const Color(0xFF238636);
  }

  @override
  Widget build(BuildContext context) {
    final fillRatio = group.filledSeats / group.totalSeats;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF21262D)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: name + seats badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  group.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _seatBadgeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _seatBadgeColor.withOpacity(0.4)),
                ),
                child: Text(
                  group.availableSeats == 0
                      ? 'Full'
                      : '${group.availableSeats} seats',
                  style: TextStyle(
                    color: _seatBadgeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Hosted by ${group.host}',
            style: const TextStyle(
              color: Color(0xFF8B949E),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          // Time & location row
          Row(
            children: [
              const Icon(Icons.access_time_outlined,
                  color: Color(0xFF8B949E), size: 14),
              const SizedBox(width: 4),
              Text(
                '${group.day} ${group.time}',
                style: const TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.location_on_outlined,
                  color: Color(0xFF8B949E), size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  group.location,
                  style: const TextStyle(
                    color: Color(0xFF8B949E),
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Capacity progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fillRatio,
              backgroundColor: const Color(0xFF21262D),
              valueColor: AlwaysStoppedAnimation<Color>(
                fillRatio >= 0.9
                    ? const Color(0xFFDA3633)
                    : fillRatio >= 0.7
                        ? const Color(0xFFD29922)
                        : Colors.white,
              ),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 12),
          // Join button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: group.isJoined || group.availableSeats == 0
                  ? null
                  : onJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: group.isJoined
                    ? const Color(0xFF238636).withOpacity(0.2)
                    : Colors.white,
                disabledBackgroundColor: group.isJoined
                    ? const Color(0xFF238636).withOpacity(0.15)
                    : const Color(0xFF21262D),
                foregroundColor:
                    group.isJoined ? const Color(0xFF238636) : Colors.black,
                disabledForegroundColor: group.isJoined
                    ? const Color(0xFF238636)
                    : const Color(0xFF484F58),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: group.isJoined
                      ? const BorderSide(color: Color(0xFF238636), width: 1)
                      : BorderSide.none,
                ),
              ),
              child: Text(
                group.isJoined
                    ? '✓ Joined'
                    : group.availableSeats == 0
                        ? 'Group is full'
                        : 'Join group',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudyGroup {
  final String name;
  final String host;
  final String day;
  final String time;
  final String location;
  final int totalSeats;
  int filledSeats;
  int availableSeats;
  bool isJoined;

  StudyGroup({
    required this.name,
    required this.host,
    required this.day,
    required this.time,
    required this.location,
    required this.totalSeats,
    required this.filledSeats,
    required this.availableSeats,
    required this.isJoined,
  });
}
