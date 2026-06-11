import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      type: NotificationType.event,
      title: 'Your RSVP is confirmed',
      subtitle: 'AI for Social Impact Workshop · Jun 5',
      timeAgo: '2h',
      isUnread: true,
    ),
    NotificationItem(
      type: NotificationType.mention,
      title: 'Fatima mentioned you',
      subtitle: 'in Entrepreneurship Club',
      timeAgo: '5h',
      isUnread: true,
    ),
    NotificationItem(
      type: NotificationType.message,
      title: 'New message from David',
      subtitle: 'Don\'t forget the meeting',
      timeAgo: '1d',
      isUnread: false,
    ),
    NotificationItem(
      type: NotificationType.group,
      title: 'You joined Tech & Innovation Hub',
      subtitle: 'Welcome aboard 🚀',
      timeAgo: '2d',
      isUnread: false,
    ),
    NotificationItem(
      type: NotificationType.alert,
      title: 'Pitch Night starts tomorrow',
      subtitle: 'Kigali Campus · 6:30 PM',
      timeAgo: '3d',
      isUnread: false,
    ),
  ];

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isUnread = false;
      }
    });
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
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_unreadCount > 0)
              Text(
                '$_unreadCount new update${_unreadCount > 1 ? 's' : ''}',
                style: const TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 12,
                ),
              ),
          ],
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const Divider(
          color: Color(0xFF1E2530),
          height: 1,
          indent: 72,
        ),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationTile(
            notification: notification,
            onTap: () {
              setState(() {
                notification.isUnread = false;
              });
            },
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isUnread
            ? const Color(0xFF161B22)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2530),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                notification.type.icon,
                color: const Color(0xFF8B949E),
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: notification.isUnread
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    notification.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8B949E),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Time + unread dot
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  notification.timeAgo,
                  style: const TextStyle(
                    color: Color(0xFF8B949E),
                    fontSize: 12,
                  ),
                ),
                if (notification.isUnread) ...[
                  const SizedBox(height: 6),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum NotificationType { event, mention, message, group, alert }

extension NotificationTypeIcon on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.event:
        return Icons.calendar_today_outlined;
      case NotificationType.mention:
        return Icons.alternate_email;
      case NotificationType.message:
        return Icons.chat_bubble_outline;
      case NotificationType.group:
        return Icons.group_outlined;
      case NotificationType.alert:
        return Icons.notifications_none_outlined;
    }
  }
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final String subtitle;
  final String timeAgo;
  bool isUnread;

  NotificationItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.isUnread,
  });
}
