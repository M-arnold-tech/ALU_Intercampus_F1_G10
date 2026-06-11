import 'package:flutter/material.dart';

// ── Data models ───────────────────────────────────────────────────────────────

enum MessageType { text, file }

class ChatMessage {
  final String? sender;
  final String content;
  final String time;
  final bool isMe;
  final MessageType type;
  final String? fileName;
  final String? fileSize;

  const ChatMessage({
    this.sender,
    required this.content,
    required this.time,
    required this.isMe,
    this.type = MessageType.text,
    this.fileName,
    this.fileSize,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class ChatDetailScreen extends StatefulWidget {
  final String groupName;
  final IconData groupIcon;
  final String memberCount;

  const ChatDetailScreen({
    super.key,
    required this.groupName,
    required this.groupIcon,
    required this.memberCount,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  late final List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List<ChatMessage>.from(_messagesForGroup(widget.groupName));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1631),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            const Divider(color: Color(0xFF1E2746), height: 1),
            Expanded(child: _buildMessageList()),
            const Divider(color: Color(0xFF1E2746), height: 1),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  // ── App bar ────────────────────────────────────────────────────────────────

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF1E2A50),
              shape: BoxShape.circle,
            ),
            child: Icon(widget.groupIcon, color: Colors.white70, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.groupName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.memberCount,
                  style: const TextStyle(
                    color: Color(0xFF8A97C0),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.phone_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // ── Message list ───────────────────────────────────────────────────────────

  Widget _buildMessageList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        _buildDayLabel('TODAY'),
        const SizedBox(height: 12),
        ..._messages.map((msg) => _buildMessageBubble(msg)),
      ],
    );
  }

  List<ChatMessage> _messagesForGroup(String groupName) {
    switch (groupName) {
      case 'Entreprenuership Club':
        return const [
          ChatMessage(
            content: 'The pitch deck is ready for review.',
            time: '8:55 AM',
            isMe: true,
          ),
          ChatMessage(
            content: 'Nice. I will bring the projector.',
            time: '9:02 AM',
            isMe: true,
          ),
          ChatMessage(
            content: 'Great, I will share the final outline today.',
            time: '9:10 AM',
            isMe: true,
          ),
        ];
      case 'AI Workshop Group':
        return const [
          ChatMessage(
            content: "Hey team! Don't forget our session tomorrow at 9am.",
            time: '9:14 AM',
            isMe: true,
          ),
          ChatMessage(
            content: "Got it! I'll bring my laptop.",
            time: '9:18 AM',
            isMe: true,
          ),
          ChatMessage(
            content: 'Can we also prepare a demo dataset?',
            time: '9:20 AM',
            isMe: true,
          ),
          ChatMessage(
            content: '',
            time: '9:32 AM',
            isMe: true,
            type: MessageType.file,
            fileName: 'Workshop Materials.pdf',
            fileSize: '2.4 MB',
          ),
        ];
      case 'Campus Leaders':
        return const [
          ChatMessage(
            content: 'See you at the student forum after class.',
            time: 'Yesterday',
            isMe: true,
          ),
          ChatMessage(
            content: 'I will be there with the agenda notes.',
            time: 'Yesterday',
            isMe: true,
          ),
          ChatMessage(
            content: 'Please review the volunteer list too.',
            time: 'Yesterday',
            isMe: true,
          ),
        ];
      case 'Travel Buddies':
        return const [
          ChatMessage(
            content: 'Any updates on the weekend trip?',
            time: 'Yesterday',
            isMe: true,
          ),
          ChatMessage(
            content: 'I checked the bus seats and they are still available.',
            time: 'Yesterday',
            isMe: true,
          ),
          ChatMessage(
            content: 'Perfect, I will confirm the hotel tonight.',
            time: 'Yesterday',
            isMe: true,
          ),
        ];
      case 'ALU Debate Society':
        return const [
          ChatMessage(
            content: 'Great job on the last round!',
            time: 'Mon',
            isMe: true,
          ),
          ChatMessage(
            content: 'Thanks, the team worked hard on the opening statement.',
            time: 'Mon',
            isMe: true,
          ),
          ChatMessage(
            content: 'We should rehearse the rebuttal tomorrow.',
            time: 'Mon',
            isMe: true,
          ),
        ];
      default:
        return [
          ChatMessage(
            content:
                'Welcome to ${widget.groupName}. Start the conversation here.',
            time: 'Today',
            isMe: true,
          ),
        ];
    }
  }

  void _sendMessage() {
    final String messageText = _controller.text.trim();
    if (messageText.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(
        ChatMessage(
          content: messageText,
          time: _currentTimeLabel(),
          isMe: true,
        ),
      );
      _controller.clear();
    });
  }

  String _currentTimeLabel() {
    final DateTime now = DateTime.now();
    final int hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final String minute = now.minute.toString().padLeft(2, '0');
    final String period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  Widget _buildDayLabel(String label) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF8A97C0),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final bool isMe = msg.isMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFE8E8EE) : const Color(0xFF1E2A50),
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
                // Sender name (group messages only, not me)
                if (!isMe && msg.sender != null) ...[
                  Text(
                    msg.sender!,
                    style: const TextStyle(
                      color: Color(0xFFB0BEE8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                // File attachment
                if (msg.type == MessageType.file) ...[
                  _buildFileAttachment(msg),
                ] else ...[
                  Text(
                    msg.content,
                    style: TextStyle(
                      color: isMe ? const Color(0xFF0F1631) : Colors.white,
                      fontSize: 14.5,
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  msg.time,
                  style: TextStyle(
                    color: isMe
                        ? const Color(0xFF6B6B80)
                        : const Color(0xFF8A97C0),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileAttachment(ChatMessage msg) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2A3560),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'PDF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.fileName ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              msg.fileSize ?? '',
              style: const TextStyle(color: Color(0xFF8A97C0), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  // ── Input bar ──────────────────────────────────────────────────────────────

  Widget _buildInputBar() {
    return Container(
      color: const Color(0xFF0F1631),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // Attach button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Color(0xFF8A97C0), size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          // Text field
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2746),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'type a message......',
                  hintStyle: TextStyle(color: Color(0xFF6B7AB0), fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Emoji button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Color(0xFF8A97C0),
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 6),
          // Send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFF3D5AFE),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}