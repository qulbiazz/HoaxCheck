class FactCheckEntity {
  final String claimText;
  final String? claimant;
  final String? claimDate;
  final String publisherName;
  final String? publisherSite;
  final String reviewTitle;
  final String reviewUrl;
  final String rating;
  final String? reviewDate;

  const FactCheckEntity({
    required this.claimText,
    this.claimant,
    this.claimDate,
    required this.publisherName,
    this.publisherSite,
    required this.reviewTitle,
    required this.reviewUrl,
    required this.rating,
    this.reviewDate,
  });

  /// Menilai apakah rating terindikasi sebagai hoaks / salah
  bool get isFalseClaim {
    final lower = rating.toLowerCase();
    return lower.contains('salah') ||
        lower.contains('hoax') ||
        lower.contains('hoaks') ||
        lower.contains('false') ||
        lower.contains('palsu') ||
        lower.contains('keliru') ||
        lower.contains('manipulasi') ||
        lower.contains('misleading') ||
        lower.contains('disinformasi');
  }
}

