import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../data/datasources/tips_remote_data_source.dart';
import '../../data/models/tip_model.dart';

class TipsSection extends StatefulWidget {
  final TipsRemoteDataSource? remoteDataSource;

  const TipsSection({super.key, this.remoteDataSource});

  @override
  State<TipsSection> createState() => _TipsSectionState();
}

class _TipsSectionState extends State<TipsSection> {
  late final TipsRemoteDataSource _dataSource;
  List<TipModel> _tips = TipModel.defaultTips;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = widget.remoteDataSource ?? TipsRemoteDataSourceImpl();
    _loadTips();
  }

  Future<void> _loadTips() async {
    try {
      final items = await _dataSource.getTips();
      if (mounted) {
        setState(() {
          _tips = items.isNotEmpty ? items : TipModel.defaultTips;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _tips = TipModel.defaultTips;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tips Mengenali Hoaks",
                  style: TextStyle(
                    color: isDark ? AppDarkColors.textPrimary : const Color(0xFF1E293B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Panduan literasi digital sehari-hari",
                  style: TextStyle(
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    ),
                  ),
                Icon(
                  Icons.swipe,
                  size: 14,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                ),
                const SizedBox(width: 4),
                Text(
                  "Geser",
                  style: TextStyle(
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _tips.map((tip) => _buildTipCard(context, tip)).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildTipCard(BuildContext context, TipModel tip) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => _showTipDetailModal(context, tip),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppDarkColors.surface : Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: tip.iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(tip.iconData, color: tip.iconColor, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              tip.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? AppDarkColors.textPrimary : const Color(0xFF1E293B),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tip.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                fontSize: 11,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              tip.tipNumber,
              style: TextStyle(
                color: tip.iconColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTipDetailModal(BuildContext context, TipModel tip) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: tip.iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(tip.iconData, color: tip.iconColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip.tipNumber,
                            style: TextStyle(
                              color: tip.iconColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            tip.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppDarkColors.textPrimary : const Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    tip.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Tutup Panduan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
