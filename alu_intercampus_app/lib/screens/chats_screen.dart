import 'package:flutter/material.dart';
import 'dart:async';
import 'chat_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF0F1631)),
      home: const ChatsScreen(),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class ChatItem {
  final IconData icon;
  final String name;
  final String lastMessage;
  final String time;
  final String memberCount;

  const ChatItem({
    required this.icon,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.memberCount,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 2;
  late final Timer _clockTimer;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<ChatItem> _chats = const [
    ChatItem(
      icon: Icons.attach_money,
      name: 'Entreprenuership Club',
      lastMessage: "David: Don't forget the meeting",
      time: '10:30 AM',
      memberCount: '18 members',
    ),
    ChatItem(
      icon: Icons.smart_toy_outlined,
      name: 'AI Workshop Group',
      lastMessage: 'Fatima: Where is it being held?',
      time: '9:45 AM',
      memberCount: '22 members',
    ),
    ChatItem(
      icon: Icons.account_balance_outlined,
      name: 'Campus Leaders',
      lastMessage: 'Jean : see you there!',
      time: 'Yesterday',
      memberCount: '14 members',
    ),
    ChatItem(
      icon: Icons.flight,
      name: 'Travel Buddies',
      lastMessage: 'Sarah: Any updates?',
      time: 'Yesterday',
      memberCount: '11 members',
    ),
    ChatItem(
      icon: Icons.record_voice_over_outlined,
      name: 'ALU Debate Society',
      lastMessage: 'Emmanuel: Great job!',
      time: 'Mon',
      memberCount: '25 members',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1631),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildChatList()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 8, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Chats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // ── Search bar ─────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2746),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          style: const TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            hintText: 'Search chats...',
            hintStyle: const TextStyle(color: Color(0xFF6B7AB0), fontSize: 15),
            prefixIcon: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  _searchQuery = _searchController.text;
                });
              },
              icon: const Icon(
                Icons.search,
                color: Color(0xFF6B7AB0),
                size: 20,
              ),
            ),
            suffixIcon: _searchController.text.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF6B7AB0),
                      size: 18,
                    ),
                  ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  // ── Chat list ──────────────────────────────────────────────────────────────

  Widget _buildChatList() {
    final List<ChatItem> filteredChats = _filteredChats();

    if (filteredChats.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'No chats found for "$_searchQuery"',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF8A97C0), fontSize: 15),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: filteredChats.length,
      separatorBuilder: (_, __) => Divider(
        color: Colors.white.withOpacity(0.08),
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) => _buildChatTile(filteredChats[index]),
    );
  }

  List<ChatItem> _filteredChats() {
    final String query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _chats;
    }

    final List<ChatItem> matchingChats = [];
    final List<ChatItem> otherChats = [];

    for (final ChatItem chat in _chats) {
      if (_matchesQuery(chat, query)) {
        matchingChats.add(chat);
      } else {
        otherChats.add(chat);
      }
    }

    return [...matchingChats, ...otherChats];
  }

  bool _matchesQuery(ChatItem chat, String query) {
    return chat.name.toLowerCase().contains(query) ||
        chat.lastMessage.toLowerCase().contains(query) ||
        chat.memberCount.toLowerCase().contains(query);
  }

  Widget _buildChatTile(ChatItem chat) {
    return InkWell(
      onTap: () => _openChat(chat),
      splashColor: Colors.white.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Avatar circle
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFF1E2A50),
                shape: BoxShape.circle,
              ),
              child: Icon(chat.icon, color: Colors.white70, size: 26),
            ),
            const SizedBox(width: 14),
            // Name + preview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: const TextStyle(
                      color: Color(0xFF8A97C0),
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Timestamp
            Text(
              _currentTimeLabel(),
              style: const TextStyle(color: Color(0xFF8A97C0), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  String _currentTimeLabel() {
    final DateTime now = DateTime.now();
    final int hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final String minute = now.minute.toString().padLeft(2, '0');
    final String period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void _openChat(ChatItem chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          groupName: chat.name,
          groupIcon: chat.icon,
          memberCount: chat.memberCount,
        ),
      ),
    );
  }

  // ── Bottom nav ─────────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xFF0F1631),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, 'Home', 0),
          _navItem(Icons.explore_outlined, 'Explore', 1),
          _fabButton(),
          _navItem(Icons.chat_bubble_outline, 'Chats', 2),
          _navItem(Icons.person_outline, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool active = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? Colors.white : const Color(0xFF5C6A99),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFF5C6A99),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fabButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: Color(0xFFF5C518),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }
}
