import 'package:flutter/material.dart';

class TipModel {
  final String id;
  final String title;
  final String description;
  final String tipNumber;
  final String iconName;
  final String? iconBgHex;
  final String? iconColorHex;
  final String category;
  final int orderIndex;

  const TipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tipNumber,
    this.iconName = 'fact_check',
    this.iconBgHex,
    this.iconColorHex,
    this.category = 'Umum',
    this.orderIndex = 0,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      tipNumber: json['tip_number']?.toString() ?? 'Tips',
      iconName: json['icon_name']?.toString() ?? 'fact_check',
      iconBgHex: json['icon_bg_hex']?.toString(),
      iconColorHex: json['icon_color_hex']?.toString(),
      category: json['category']?.toString() ?? 'Umum',
      orderIndex: json['order_index'] is int
          ? json['order_index'] as int
          : int.tryParse(json['order_index']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tip_number': tipNumber,
      'icon_name': iconName,
      'icon_bg_hex': iconBgHex,
      'icon_color_hex': iconColorHex,
      'category': category,
      'order_index': orderIndex,
    };
  }

  IconData get iconData {
    switch (iconName.toLowerCase()) {
      case 'campaign':
      case 'campaign_outlined':
      case 'speaker':
        return Icons.campaign_outlined;
      case 'search':
      case 'search_outlined':
      case 'lens':
        return Icons.search_rounded;
      case 'date_range':
      case 'calendar':
      case 'calendar_today':
        return Icons.date_range_outlined;
      case 'psychology':
      case 'brain':
        return Icons.psychology_outlined;
      case 'verified':
      case 'check_circle':
        return Icons.verified_outlined;
      case 'link':
      case 'url':
        return Icons.link_rounded;
      case 'fact_check':
      case 'fact_check_outlined':
      default:
        return Icons.fact_check_outlined;
    }
  }

  Color get iconBgColor {
    if (iconBgHex != null && iconBgHex!.isNotEmpty) {
      final hex = iconBgHex!.replaceAll('#', '');
      if (hex.length == 6) {
        return Color(int.parse('0xFF$hex'));
      } else if (hex.length == 8) {
        return Color(int.parse('0x$hex'));
      }
    }
    // Default warna berdasarkan tip number
    if (tipNumber.contains('2')) {
      return const Color(0xFFFFE4E6);
    } else if (tipNumber.contains('3')) {
      return const Color(0xFFE0F2FE);
    }
    return const Color(0xFFD1FAE5);
  }

  Color get iconColor {
    if (iconColorHex != null && iconColorHex!.isNotEmpty) {
      final hex = iconColorHex!.replaceAll('#', '');
      if (hex.length == 6) {
        return Color(int.parse('0xFF$hex'));
      } else if (hex.length == 8) {
        return Color(int.parse('0x$hex'));
      }
    }
    if (tipNumber.contains('2')) {
      return const Color(0xFFE11D48);
    } else if (tipNumber.contains('3')) {
      return const Color(0xFF0284C7);
    }
    return const Color(0xFF059669);
  }

  static List<TipModel> get defaultTips => const [
        TipModel(
          id: 'tip-1',
          title: 'Periksa sumber informasi',
          description:
              'Pastikan diterbitkan oleh portal berita resmi yang terverifikasi dan terdaftar di Dewan Pers.',
          tipNumber: 'Tips #1',
          iconName: 'fact_check',
          iconBgHex: '#D1FAE5',
          iconColorHex: '#059669',
          orderIndex: 1,
        ),
        TipModel(
          id: 'tip-2',
          title: 'Waspada judul',
          description:
              'Jangan langsung percaya judul berita yang bombastis dan clickbait yang memicu emosi.',
          tipNumber: 'Tips #2',
          iconName: 'campaign',
          iconBgHex: '#FFE4E6',
          iconColorHex: '#E11D48',
          orderIndex: 2,
        ),
        TipModel(
          id: 'tip-3',
          title: 'Cek Tanggal & Konteks',
          description:
              'Periksa tanggal rilis artikel untuk memastikan berita bukan daur ulang lama yang dipelintir.',
          tipNumber: 'Tips #3',
          iconName: 'date_range',
          iconBgHex: '#E0F2FE',
          iconColorHex: '#0284C7',
          orderIndex: 3,
        ),
      ];
}
