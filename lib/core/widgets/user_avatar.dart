import 'package:flutter/material.dart';
import '../../app/theme.dart';

/// Widget Avatar Pengguna yang adaptif:
/// - Menampilkan foto dari URL jika tersedia (misal login dengan akun Google)
/// - Menampilkan avatar ikon default yang rapi dan konsisten jika pengguna
///   mendaftar langsung dari aplikasi (tanpa foto profil kustom)
class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;
  final BoxShadow? shadow;

  const UserAvatar({
    super.key,
    this.avatarUrl,
    this.size = 36,
    this.onTap,
    this.borderColor,
    this.borderWidth = 1.5,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderColor = borderColor ??
        (isDark ? AppDarkColors.border : Colors.grey.shade300);

    final hasNetworkAvatar = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    Widget avatarContent;
    if (hasNetworkAvatar) {
      avatarContent = Image.network(
        avatarUrl!.trim(),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(isDark),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size,
            height: size,
            color: isDark
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.primary.withValues(alpha: 0.1),
            child: Center(
              child: SizedBox(
                width: size * 0.4,
                height: size * 0.4,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        },
      );
    } else {
      avatarContent = _buildDefaultAvatar(isDark);
    }

    Widget container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
        boxShadow: shadow != null ? [shadow!] : null,
      ),
      child: ClipOval(child: avatarContent),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }

  Widget _buildDefaultAvatar(bool isDark) {
    return Container(
      width: size,
      height: size,
      color: isDark
          ? AppColors.primary.withValues(alpha: 0.22)
          : AppColors.primary.withValues(alpha: 0.12),
      child: Center(
        child: Icon(
          Icons.person_rounded,
          size: size * 0.58,
          color: isDark ? AppColors.secondary : AppColors.primary,
        ),
      ),
    );
  }
}
