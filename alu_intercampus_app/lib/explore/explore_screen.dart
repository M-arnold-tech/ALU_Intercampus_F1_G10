import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

// ── Colour palette (matches design mockup) ──────────────────────────────────
const Color kBg         = Color(0xFF0D1B2A);
const Color kSurface    = Color(0xFF152236);
const Color kCard       = Color(0xFF1B2D45);
const Color kBorder     = Color(0xFF3A4D65);
const Color kGold       = Color(0xFFC8972E);
const Color kWhite      = Color(0xFFFFFFFF);
const Color kMuted      = Color(0xFF7A8FA8);
const Color kSubtle     = Color(0xFFAABBCC);

// ── Mock data ────────────────────────────────────────────────────────────────
class OpportunityItem {
  final String id, title, deadline, campus, tag, imageUrl;
  const OpportunityItem({
    required this.id,
    required this.title,
    required this.deadline,
    required this.campus,
    required this.tag,
    required this.imageUrl,
  });
}

class TrendingItem {
  final String id, title, date, tag, imageUrl;
  const TrendingItem({
    required this.id,
    required this.title,
    required this.date,
    required this.tag,
    required this.imageUrl,
  });
}

const _recommended = [
  OpportunityItem(
    id: '1',
    title: 'Sustainable Solution Challenge',
    deadline: 'Apply by May 20, 2026',
    campus: 'Mauritius Campus',
    tag: 'COMPETITION',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=120&q=80',
  ),
  OpportunityItem(
    id: '2',
    title: 'Campus Ambassador Program',
    deadline: 'Apply by May 22, 2026',
    campus: 'All Campus',
    tag: 'OPPORTUNITY',
    imageUrl: 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=120&q=80',
  ),
  OpportunityItem(
    id: '3',
    title: 'ALU Climate Action Week',
    deadline: 'Apply by May 28, 2026',
    campus: 'Both Campus',
    tag: 'EVENT',
    imageUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=120&q=80',
  ),
  OpportunityItem(
    id: '4',
    title: 'Build Your First MVP Workshop',
    deadline: 'Apply by Jun 02, 2026',
    campus: 'All Campus',
    tag: 'EVENT',
    imageUrl: 'https://images.unsplash.com/photo-1531545514256-b1400bc00f31?w=120&q=80',
  ),
];

const _trending = [
  TrendingItem(
    id: '5',
    title: 'Community Clean Up',
    date: 'May 18, 2026',
    tag: 'EVENT',
    imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300&q=80',
  ),
  TrendingItem(
    id: '6',
    title: 'AI for Social Impact Workshops',
    date: 'Jun 5, 2026',
    tag: 'WORKSHOP',
    imageUrl: 'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=300&q=80',
  ),
  TrendingItem(
    id: '7',
    title: 'Design Thinking Bootcamp',
    date: 'May 30, 2026',
    tag: 'WORKSHOP',
    imageUrl: 'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?w=300&q=80',
  ),
  TrendingItem(
    id: '8',
    title: 'Pitch Night',
    date: 'May 24, 2026',
    tag: 'EVENT',
    imageUrl: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=300&q=80',
  ),
];

const _filters = ['All', 'Events', 'Opportunities', 'Clubs'];

// ── Screen ───────────────────────────────────────────────────────────────────
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _activeFilter = 'All';
  String _searchText   = '';

  // Filter helpers
  bool _recMatches(OpportunityItem item) {
    final matchSearch = _searchText.isEmpty ||
        item.title.toLowerCase().contains(_searchText.toLowerCase()) ||
        item.campus.toLowerCase().contains(_searchText.toLowerCase());
    final matchFilter = _activeFilter == 'All' ||
        (_activeFilter == 'Events'        && item.tag == 'EVENT') ||
        (_activeFilter == 'Opportunities' && item.tag == 'OPPORTUNITY') ||
        (_activeFilter == 'Clubs'         && item.tag == 'CLUB');
    return matchSearch && matchFilter;
  }

  bool _trendMatches(TrendingItem item) {
    final matchSearch = _searchText.isEmpty ||
        item.title.toLowerCase().contains(_searchText.toLowerCase());
    final matchFilter = _activeFilter == 'All' ||
        (_activeFilter == 'Events'        && item.tag == 'EVENT') ||
        (_activeFilter == 'Opportunities' && item.tag == 'WORKSHOP');
    return matchSearch && matchFilter;
  }

  void _openDetail(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EventDetailScreen(item: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRec   = _recommended.where(_recMatches).toList();
    final filteredTrend = _trending.where(_trendMatches).toList();

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: kCard, borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.arrow_back, color: kWhite, size: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Explore',
                      style: TextStyle(
                        color: kWhite, fontSize: 24, fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Search bar ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kCard, borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    style: const TextStyle(color: kWhite, fontSize: 15),
                    onChanged: (v) => setState(() => _searchText = v),
                    decoration: const InputDecoration(
                      hintText: 'Search events, opportunities…',
                      hintStyle: TextStyle(color: kMuted),
                      prefixIcon: Icon(Icons.search, color: kMuted),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
            ),

            // ── Filter pills ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 52,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final f       = _filters[i];
                    final active  = _activeFilter == f;
                    return GestureDetector(
                      onTap: () => setState(() => _activeFilter = f),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? kWhite : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: active ? kWhite : kBorder),
                        ),
                        child: Text(
                          f,
                          style: TextStyle(
                            color: active ? kBg : kSubtle,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── "Recommended for you" label ─────────────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 22, 16, 10),
                child: Text(
                  'RECOMMENDED FOR YOU',
                  style: TextStyle(
                    color: kWhite, fontSize: 13,
                    fontWeight: FontWeight.w700, letterSpacing: 0.8,
                  ),
                ),
              ),
            ),

            // ── Recommended list ─────────────────────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  if (filteredRec.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('No results.', style: TextStyle(color: kMuted)),
                    );
                  }
                  final item = filteredRec[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: _RecommendedCard(
                      item: item,
                      onTap: () => _openDetail({
                        'id': item.id,
                        'title': item.title,
                        'date': item.deadline,
                        'time': '09:00 AM',
                        'campus': item.campus,
                        'location': 'Main Hall',
                        'tag': item.tag,
                        'categories': [item.tag],
                        'going': 0,
                        'interested': 0,
                        'description': 'More details coming soon.',
                        'imageUrl': item.imageUrl,
                      }),
                    ),
                  );
                },
                childCount: filteredRec.isEmpty ? 1 : filteredRec.length,
              ),
            ),

            // ── "Trending events" label ─────────────────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Text(
                  'TRENDING EVENTS',
                  style: TextStyle(
                    color: kWhite, fontSize: 13,
                    fontWeight: FontWeight.w700, letterSpacing: 0.8,
                  ),
                ),
              ),
            ),

            // ── Trending 2-column grid ───────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final item = filteredTrend[i];
                    return _TrendingCard(
                      item: item,
                      onTap: () => _openDetail({
                        'id': item.id,
                        'title': item.title,
                        'date': item.date,
                        'time': '09:00 AM',
                        'campus': 'All Campus',
                        'location': 'TBD',
                        'tag': item.tag,
                        'categories': [item.tag],
                        'going': 0,
                        'interested': 0,
                        'description': 'More details coming soon.',
                        'imageUrl': item.imageUrl,
                      }),
                    );
                  },
                  childCount: filteredTrend.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Recommended card widget ─────────────────────────────────────────────────
class _RecommendedCard extends StatelessWidget {
  final OpportunityItem item;
  final VoidCallback onTap;
  const _RecommendedCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kSurface, borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.imageUrl,
                width: 64, height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 64, height: 64, color: kCard,
                  child: const Icon(Icons.image, color: kMuted),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kWhite, fontSize: 14, fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.deadline} · ${item.campus}',
                    style: const TextStyle(color: kMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kBorder),
              ),
              child: Text(
                item.tag,
                style: const TextStyle(
                  color: kWhite, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Trending card widget ────────────────────────────────────────────────────
class _TrendingCard extends StatelessWidget {
  final TrendingItem item;
  final VoidCallback onTap;
  const _TrendingCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: kCard),
            ),
            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC0D1B2A)],
                  stops: [0.45, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 10, right: 10, bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kWhite, fontSize: 13, fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.date,
                    style: const TextStyle(color: kSubtle, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
