import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class HistoryHeader extends StatelessWidget {
  final VoidCallback? onDeleteAll;

  const HistoryHeader({
    super.key,
    this.onDeleteAll,
  });

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Hapus Riwayat",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          content: const Text(
            "Apakah Anda yakin ingin menghapus seluruh riwayat pemeriksaan? Tindakan ini tidak dapat dibatalkan.",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                    child: const Text(
                      "Batal",
                      style: TextStyle(
                        color: Color(0xFF334155),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (onDeleteAll != null) {
                        onDeleteAll!();
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC2626),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Hapus",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Riwayat Pemeriksaan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Arsip analisis teks yang pernah kamu lakukan.",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _showDeleteConfirmation(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.delete_outline_rounded,
                  size: 14,
                  color: Color(0xFFDC2626),
                ),
                SizedBox(width: 4),
                Text(
                  "Hapus",
                  style: TextStyle(
                    color: Color(0xFFDC2626),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}