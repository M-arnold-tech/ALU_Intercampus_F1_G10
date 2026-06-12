import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';
import 'package:alu_intercampus_app/screens/chatdetail_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  static const List<Map<String, dynamic>> _chats = [
    {
      'name': 'Entreprenuership Club',
      'icon': Icons.attach_money,
      'preview': 'David: Don\'t forget the meeting',
      'time': '10:30 AM',
      'color': Color(0xFF3D5A99),
    },
    {
      'name': 'AI Workshop Group',
      'icon': Icons.smart_toy_outlined,
      'preview': 'Fatima: Where is it being held?',
      'time': '945 AM',
      'color': Color(0xFF2AA198),
    },
    {
      'name': 'Campus Leaders',
      'icon': Icons.account_balance_outlined,
      'preview': 'Jean : see you there!',
      'time': 'Yesterday',
      'color': Color(0xFF5C6BC0),
    },
    {
      'name': 'Travel Buddies',
      'icon': Icons.flight_outlined,
      'preview': 'Sarah: Any updates?',
      'time': 'Yesterday',
      'color': Color(0xFF26A69A),
    },
    {
      'name': 'ALU Debate Society',
      'icon': Icons.record_voice_over_outlined,
      'preview': 'Emmanuel: Great job!',
      'time': 'Mon',
      'color': Color(0xFF7E57C2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Header 
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Chats',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const Icon(Icons.edit_outlined,
                      color: Colors.white, size: 22),
                ],
              ),
            ),

            //  Search 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.white54, size: 18),
                    SizedBox(width: 8),
                    Text('Search chats...',
                        style:
                            TextStyle(color: Colors.white38, fontSize: 14)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            //  Divider 
            Divider(color: Colors.white.withOpacity(0.08), height: 1),

            //  Chat list 
            Expanded(
              child: ListView.separated(
                itemCount: _chats.length,
                separatorBuilder: (_, __) => Divider(
                    color: Colors.white.withOpacity(0.06),
                    height: 1,
                    indent: 76),
                itemBuilder: (_, i) {
                  final chat = _chats[i];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (chat['color'] as Color).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(chat['icon'] as IconData,
                          color: Colors.white, size: 22),
                    ),
                    title: Text(chat['name'] as String,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    subtitle: Text(chat['preview'] as String,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    trailing: Text(chat['time'] as String,
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 12)),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(
                          groupName: chat['name'] as String,
                          groupIcon: chat['icon'] as IconData,
                          iconColor: chat['color'] as Color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}