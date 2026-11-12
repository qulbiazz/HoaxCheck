import 'package:flutter/material.dart';

class HistoryDeleteDialog extends StatelessWidget {
  final VoidCallback onDeleteAll;

  const HistoryDeleteDialog({
    super.key,
    required this.onDeleteAll,
  });

  @override
  Widget build(BuildContext context) {
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
                  onDeleteAll();
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
  }
}