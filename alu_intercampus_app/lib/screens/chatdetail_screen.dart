import 'package:flutter/material.dart';
import 'package:alu_intercampus_app/onboarding/app_theme.dart';

class ChatDetailScreen extends StatefulWidget {
  final String groupName;
  final IconData groupIcon;
  final Color iconColor;

  const ChatDetailScreen({
    super.key,
    required this.groupName,
    required this.groupIcon,
    required this.iconColor,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      sender: 'Fatima',
      text: "Hey team! Don't forget our session tomorrow at 9am. See you there!",
      time: '9:14 AM',
      isMe: false,
      isFile: false,
    ),
    _ChatMessage(
      sender: '',
      text: "Got it! I'll bring my laptop.",
      time: '9:18 AM',
      isMe: true,
      isFile: false,
    ),
    _ChatMessage(
      sender: 'David',
      text: "Can't wait!",
      time: '9:20 AM',
      isMe: false,
      isFile: false,
    ),
    _ChatMessage(
      sender: 'Fatima',
      text: 'Workshop Materials.pdf\n2.4 MB',
      time: '9:32 AM',
      isMe: false,
      isFile: true,
    ),
  ];

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(
        sender: '',
        text: text,
        time: _timeNow(),
        isMe: true,
        isFile: false,
      ));
    });
    _inputController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  String _timeNow() {
    final now = DateTime.now();
    final h = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final m = now.minute.toString().padLeft(2, '0');
    final period = now.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $period';
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //  App bar 
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  bottom: BorderSide(
                      color: Colors.white.withOpacity(0.08), width: 1),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.iconColor.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.groupIcon,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.groupName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const Text('22 members',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.call_outlined,
                      color: Colors.white, size: 22),
                ],
              ),
            ),

            //  Messages 
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16),
                children: [
                  // Date label
                  const Center(
                    child: Text('TODAY',
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                            letterSpacing: 1)),
                  ),
                  const SizedBox(height: 16),
                  ..._messages.map((m) => _MessageBubble(message: m)),
                ],
              ),
            ),

            // Input bar 
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(
                      color: Colors.white.withOpacity(0.08), width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Attach
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.add,
                        color: Colors.white54, size: 24),
                  ),
                  const SizedBox(width: 8),

                  // Text field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type a message......',
                                hintStyle: TextStyle(
                                    color: Colors.white38, fontSize: 14),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          const Icon(Icons.sentiment_satisfied_alt_outlined,
                              color: Colors.white38, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send,
                          color: Colors.white70, size: 18),
                    ),
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

// Data model 

class _ChatMessage {
  final String sender;
  final String text;
  final String time;
  final bool isMe;
  final bool isFile;

  const _ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
    required this.isFile,
  });
}

// Bubble widget 

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.70),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFE8E8E8) : AppColors.cardBackground,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender name (only for others)
            if (!isMe && message.sender.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(message.sender,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
              ),

            // File attachment
            if (message.isFile)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('PDF',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message.text.split('\n').first,
                      style: TextStyle(
                          color: isMe ? Colors.black87 : Colors.white,
                          fontSize: 14),
                    ),
                  ),
                ],
              )
            else
              Text(
                message.text,
                style: TextStyle(
                    color: isMe ? Colors.black87 : Colors.white,
                    fontSize: 14),
              ),

            // File size
            if (message.isFile && message.text.contains('\n'))
              Text(
                message.text.split('\n').last,
                style: const TextStyle(
                    color: Colors.white54, fontSize: 11),
              ),

            const SizedBox(height: 4),
            Text(message.time,
                style: TextStyle(
                    color: isMe
                        ? Colors.black38
                        : Colors.white38,
                    fontSize: 11)),
          ],
        ),
      ),
    );
  }
}