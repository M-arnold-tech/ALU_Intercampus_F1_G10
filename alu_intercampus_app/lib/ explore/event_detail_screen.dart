import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Colour palette (shared with ExploreScreen) ───────────────────────────────
const Color kBg      = Color(0xFF0D1B2A);
const Color kSurface = Color(0xFF152236);
const Color kCard    = Color(0xFF1B2D45);
const Color kBorder  = Color(0xFF3A4D65);
const Color kGold    = Color(0xFFC8972E);
const Color kWhite   = Color(0xFFFFFFFF);
const Color kMuted   = Color(0xFF7A8FA8);
const Color kSubtle  = Color(0xFFAABBCC);
const Color kDivider = Color(0xFF1F3450);

// ── Screen ───────────────────────────────────────────────────────────────────
class EventDetailScreen extends StatefulWidget {
  /// Accepts a Map of event data passed from ExploreScreen or any other screen.
  /// All keys are optional — sensible defaults are provided.
  final Map<String, dynamic> item;

  const EventDetailScreen({super.key, required this.item});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  // RSVP state: 'none' | 'going' | 'interested'
  String _rsvpState = 'none';
  late int _goingCount;
  late int _interestedCount;

  @override
  void initState() {
    super.initState();
    _goingCount      = (widget.item['going']      as int?) ?? 128;
    _interestedCount = (widget.item['interested'] as int?) ?? 12;
  }

  void _handleRsvp() {
    setState(() {
      if (_rsvpState == 'going') {
        _rsvpState = 'none';
        _goingCount--;
      } else {
        if (_rsvpState == 'interested') _interestedCount--;
        _rsvpState = 'going';
        _goingCount++;
      }
    });
  }

  void _handleInterested() {
    setState(() {
      if (_rsvpState == 'interested') {
        _rsvpState = 'none';
        _interestedCount--;
      } else {
        if (_rsvpState == 'going') _goingCount--;
        _rsvpState = 'interested';
        _interestedCount++;
      }
    });
  }

  Future<void> _handleShare() async {
    final title  = widget.item['title']  ?? 'Event';
    final date   = widget.item['date']   ?? '';
    final campus = widget.item['campus'] ?? '';
    await Clipboard.setData(
      ClipboardData(text: 'Check out "$title" on $date at $campus!'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard'),
        backgroundColor: Color(0xFF1B2D45),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pull data with safe defaults
    final title       = widget.item['title']       as String? ?? 'Event';
    final date        = widget.item['date']        as String? ?? '';
    final time        = widget.item['time']        as String? ?? '09:00 AM';
    final campus      = widget.item['campus']      as String? ?? '';
    final location    = widget.item['location']    as String? ?? '';
    final description = widget.item['description'] as String? ?? '';
    final imageUrl    = widget.item['imageUrl']    as String? ?? '';
    final categories  = (widget.item['categories'] as List<dynamic>?)
        ?.cast<String>() ?? ['Event'];

    // Mock avatar URLs (shows 4 stacked profile pictures)
    const avatarUrls = [
      'https://i.pravatar.cc/40?img=1',
      'https://i.pravatar.cc/40?img=2',
      'https://i.pravatar.cc/40?img=3',
      'https://i.pravatar.cc/40?img=4',
    ];

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero image ────────────────────────────────────────────────
              Stack(
                children: [
                  // Image
                  SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: kCard),
                          )
                        : Container(color: kCard),
                  ),
                  // Back button
                  Positioned(
                    top: 16, left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.arrow_back, color: kWhite, size: 18),
                      ),
                    ),
                  ),
                  // Share button
                  Positioned(
                    top: 16, right: 16,
                    child: GestureDetector(
                      onTap: _handleShare,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.share_outlined, color: kWhite, size: 18),
                      ),
                    ),
                  ),
                ],
              ),

              // ── Body ──────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Category chips
                    Wrap(
                      spacing: 8,
                      children: categories.map((cat) => _CategoryChip(label: cat)).toList(),
                    ),
                    const SizedBox(height: 14),

                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        color: kWhite, fontSize: 22,
                        fontWeight: FontWeight.w700, height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Info card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kSurface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _InfoRow(
                            icon: Icons.calendar_today_outlined,
                            main: date,
                            sub: time,
                          ),
                          const _Divider(),
                          _InfoRow(
                            icon: Icons.location_on_outlined,
                            main: campus,
                            sub: location,
                          ),
                          const _Divider(),
                          _InfoRow(
                            icon: Icons.group_outlined,
                            main: '$_goingCount going',
                            sub: '$_interestedCount interested',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      description,
                      style: const TextStyle(
                        color: kSubtle, fontSize: 14, height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Avatar row
                    Row(
                      children: [
                        _AvatarStack(avatarUrls: avatarUrls),
                        const SizedBox(width: 12),
                        Text(
                          '${_goingCount > avatarUrls.length ? _goingCount - avatarUrls.length : _goingCount} going',
                          style: const TextStyle(color: kSubtle, fontSize: 13),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '$_interestedCount interested',
                          style: const TextStyle(color: kMuted, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // RSVP + Interested buttons
                    Row(
                      children: [
                        // RSVP
                        Expanded(
                          child: GestureDetector(
                            onTap: _handleRsvp,
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: _rsvpState == 'going'
                                    ? const Color(0xFFE0AE40)
                                    : kGold,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _rsvpState == 'going' ? '✓  GOING' : 'RSVP',
                                style: TextStyle(
                                  color: _rsvpState == 'going' ? kBg : kWhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Interested
                        Expanded(
                          child: GestureDetector(
                            onTap: _handleInterested,
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: _rsvpState == 'interested'
                                    ? kGold.withOpacity(0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: kGold,
                                  width: 1.5,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _rsvpState == 'interested'
                                    ? '✓  Interested'
                                    : 'Interested',
                                style: TextStyle(
                                  color: _rsvpState == 'interested'
                                      ? const Color(0xFFE0AE40)
                                      : kGold,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // See all RSVPs
                    Center(
                      child: GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('View your RSVPs in your Profile'),
                            backgroundColor: Color(0xFF1B2D45),
                            duration: Duration(seconds: 2),
                          ),
                        ),
                        child: const Text(
                          'See all my RSVPs',
                          style: TextStyle(
                            color: kMuted,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: kMuted,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper widgets ───────────────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
      ),
      child: Text(
        label,
        style: const TextStyle(color: kSubtle, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String main;
  final String sub;
  const _InfoRow({required this.icon, required this.main, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: kCard, borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kSubtle, size: 20),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(main, style: const TextStyle(color: kWhite, fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(sub,  style: const TextStyle(color: kMuted,  fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(color: kDivider, thickness: 1, height: 1);
  }
}

class _AvatarStack extends StatelessWidget {
  final List<String> avatarUrls;
  const _AvatarStack({required this.avatarUrls});

  @override
  Widget build(BuildContext context) {
    const double size = 34;
    const double overlap = 12;
    final count = avatarUrls.length.clamp(0, 4);
    final width = size + (count - 1) * (size - overlap);

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: List.generate(count, (i) {
          return Positioned(
            left: i * (size - overlap),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kBg, width: 2),
              ),
              child: CircleAvatar(
                radius: size / 2,
                backgroundImage: NetworkImage(avatarUrls[i]),
                backgroundColor: kCard,
              ),
            ),
          );
        }),
      ),
    );
  }
}
