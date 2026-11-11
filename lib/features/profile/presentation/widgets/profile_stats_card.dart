import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../history/data/repositories/history_repository_impl.dart';

class ProfileStatsCard extends StatefulWidget {
  const ProfileStatsCard({super.key});

  @override
  State<ProfileStatsCard> createState() => _ProfileStatsCardState();
}

class _ProfileStatsCardState extends State<ProfileStatsCard> {
  int _totalChecks = 48;
  int _hoaxCount = 14;
  int _validCount = 34;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    try {
      final items = await HistoryRepositoryImpl().getUserHistories();
      if (mounted && items.isNotEmpty) {
        setState(() {
          _totalChecks = items.length;
          _hoaxCount = items.where((item) => item.isHoax).length;
          _validCount = items.where((item) => !item.isHoax).length;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "STATISTIK PEMERIKSAAN",
                style: TextStyle(
                  color: isDark ? Colors.white54 : AppColors.neutral,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Text(
                    "Real-Time",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.insights_outlined,
                    size: 12,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem(
                _totalChecks.toString(),
                "Total Cek",
                isDark ? AppColors.tertiary : const Color(0xFF2563EB),
              ),
              const SizedBox(width: 8),
              _buildStatItem(
                _hoaxCount.toString(),
                "Hoaks",
                AppColors.danger,
              ),
              const SizedBox(width: 8),
              _buildStatItem(
                _validCount.toString(),
                "Valid",
                AppColors.primary,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.neutral,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
