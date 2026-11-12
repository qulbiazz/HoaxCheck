import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String? userId;
  final String title;
  final String description;
  final String timeLabel;
  final String tagLabel;
  final bool isUnread;
  final DateTime? createdAt;

  const NotificationModel({
    required this.id,
    this.userId,
    required this.title,
    required this.description,
    required this.timeLabel,
    required this.tagLabel,
    required this.isUnread,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['created_at'] != null) {
      try {
        parsedDate = DateTime.parse(json['created_at'].toString()).toLocal();
      } catch (_) {}
    }

    return NotificationModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString(),
      title: json['title']?.toString() ?? 'Pemberitahuan',
      description: json['description']?.toString() ?? '',
      timeLabel: json['time_label']?.toString() ?? 'Baru saja',
      tagLabel: json['tag_label']?.toString() ?? 'Info',
      isUnread: json['is_unread'] == true,
      createdAt: parsedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (userId != null) 'user_id': userId,
      'title': title,
      'description': description,
      'time_label': timeLabel,
      'tag_label': tagLabel,
      'is_unread': isUnread,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? timeLabel,
    String? tagLabel,
    bool? isUnread,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      timeLabel: timeLabel ?? this.timeLabel,
      tagLabel: tagLabel ?? this.tagLabel,
      isUnread: isUnread ?? this.isUnread,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Waktu dinamis (misal: "Baru saja", "5 mnt lalu", "14:20 WIB", "10 Nov 2026")
  String get displayTime {
    if (createdAt == null) return timeLabel;

    final now = DateTime.now();
    final difference = now.difference(createdAt!);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mnt lalu';
    } else if (difference.inHours < 24 && createdAt!.day == now.day) {
      final hour = createdAt!.hour.toString().padLeft(2, '0');
      final minute = createdAt!.minute.toString().padLeft(2, '0');
      return '$hour:$minute WIB';
    } else if (difference.inDays < 2) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
    }
  }

  /// Kelompok waktu untuk header list ("HARI INI", "KEMARIN", "SEBELUMNYA")
  String get groupCategory {
    if (createdAt == null) return 'HARI INI';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(createdAt!.year, createdAt!.month, createdAt!.day);

    final diffDays = today.difference(itemDate).inDays;
    if (diffDays == 0) {
      return 'HARI INI';
    } else if (diffDays == 1) {
      return 'KEMARIN';
    } else {
      return 'SEBELUMNYA';
    }
  }

  IconData get icon {
    final lowerTag = tagLabel.toLowerCase();
    if (lowerTag.contains('waspada') || lowerTag.contains('hoaks') || lowerTag.contains('alert')) {
      return Icons.warning_amber_rounded;
    } else if (lowerTag.contains('verifikasi') || lowerTag.contains('analisis') || lowerTag.contains('arsip')) {
      return Icons.verified_outlined;
    } else if (lowerTag.contains('tanggap') || lowerTag.contains('laporan') || lowerTag.contains('tim')) {
      return Icons.mark_chat_read_outlined;
    } else if (lowerTag.contains('literasi') || lowerTag.contains('tips') || lowerTag.contains('edukasi')) {
      return Icons.lightbulb_outline;
    }
    return Icons.notifications_outlined;
  }

  Color get iconColor {
    final lowerTag = tagLabel.toLowerCase();
    if (lowerTag.contains('waspada') || lowerTag.contains('hoaks') || lowerTag.contains('alert')) {
      return const Color(0xFFDC2626);
    } else if (lowerTag.contains('verifikasi') || lowerTag.contains('analisis') || lowerTag.contains('arsip')) {
      return const Color(0xFF059669);
    } else if (lowerTag.contains('tanggap') || lowerTag.contains('laporan') || lowerTag.contains('tim')) {
      return const Color(0xFF2563EB);
    } else if (lowerTag.contains('literasi') || lowerTag.contains('tips') || lowerTag.contains('edukasi')) {
      return const Color(0xFFD97706);
    }
    return const Color(0xFF475569);
  }

  Color get iconBgColor {
    final lowerTag = tagLabel.toLowerCase();
    if (lowerTag.contains('waspada') || lowerTag.contains('hoaks') || lowerTag.contains('alert')) {
      return const Color(0xFFFEE2E2);
    } else if (lowerTag.contains('verifikasi') || lowerTag.contains('analisis') || lowerTag.contains('arsip')) {
      return const Color(0xFFD1FAE5);
    } else if (lowerTag.contains('tanggap') || lowerTag.contains('laporan') || lowerTag.contains('tim')) {
      return const Color(0xFFDBEAFE);
    } else if (lowerTag.contains('literasi') || lowerTag.contains('tips') || lowerTag.contains('edukasi')) {
      return const Color(0xFFFEF3C7);
    }
    return const Color(0xFFF1F5F9);
  }

  Color get tagTextColor => iconColor;
  Color get tagBgColor => iconBgColor;
}
