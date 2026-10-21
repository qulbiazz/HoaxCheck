import 'package:flutter/material.dart';

class NotificationItemCard extends StatelessWidget {
  final bool isUnread;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String time;
  final String description;
  final String tagLabel;
  final Color tagBgColor;
  final Color tagTextColor;

  const NotificationItemCard({
    super.key,
    required this.isUnread,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.description,
    required this.tagLabel,
    required this.tagBgColor,
    required this.tagTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: isUnread ? const Color(0xFF047857) : Colors.transparent,
            width: 4,
          ),
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x05000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isUnread) ...[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF047857),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B), height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: tagBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tagLabel,
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: tagTextColor),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.more_vert, size: 16, color: Color(0xFF94A3B8)),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right, size: 16, color: Color(0xFF94A3B8)),
                        ],
                      ),
                    ],
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