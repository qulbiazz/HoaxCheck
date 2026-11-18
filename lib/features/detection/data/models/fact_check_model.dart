import '../../domain/entities/fact_check_entity.dart';

class FactCheckModel extends FactCheckEntity {
  const FactCheckModel({
    required super.claimText,
    super.claimant,
    super.claimDate,
    required super.publisherName,
    super.publisherSite,
    required super.reviewTitle,
    required super.reviewUrl,
    required super.rating,
    super.reviewDate,
  });

  /// Factory untuk mem-parse satu item claim dan review pertama dari Google Fact Check API
  factory FactCheckModel.fromJson(Map<String, dynamic> claimJson) {
    final claimText = claimJson['text']?.toString() ?? 'Klaim Tidak Berjudul';
    final claimant = claimJson['claimant']?.toString();
    final claimDate = claimJson['claimDate']?.toString();

    final reviews = claimJson['claimReview'] as List<dynamic>?;
    if (reviews != null && reviews.isNotEmpty) {
      final firstReview = reviews.first as Map<String, dynamic>;
      final publisher = firstReview['publisher'] as Map<String, dynamic>?;
      final publisherName = publisher?['name']?.toString() ?? 'Pemeriksa Fakta Terverifikasi';
      final publisherSite = publisher?['site']?.toString();
      final reviewTitle = firstReview['title']?.toString() ?? claimText;
      final reviewUrl = firstReview['url']?.toString() ?? '';
      final rating = firstReview['textualRating']?.toString() ?? 'Klaim Diperiksa';
      final reviewDate = firstReview['reviewDate']?.toString();

      return FactCheckModel(
        claimText: claimText,
        claimant: claimant,
        claimDate: claimDate,
        publisherName: publisherName,
        publisherSite: publisherSite,
        reviewTitle: reviewTitle,
        reviewUrl: reviewUrl,
        rating: rating,
        reviewDate: reviewDate,
      );
    }

    return FactCheckModel(
      claimText: claimText,
      claimant: claimant,
      claimDate: claimDate,
      publisherName: 'Pemeriksa Fakta',
      publisherSite: null,
      reviewTitle: claimText,
      reviewUrl: '',
      rating: 'Dalam Pemeriksaan',
      reviewDate: null,
    );
  }

  /// Ekstraksi seluruh item claimReview jika satu claim memiliki multi-review dari berbagai publisher
  static List<FactCheckModel> fromClaimsJsonList(List<dynamic> claimsJsonList) {
    final List<FactCheckModel> results = [];
    for (final claim in claimsJsonList) {
      if (claim is Map<String, dynamic>) {
        final reviews = claim['claimReview'] as List<dynamic>?;
        final claimText = claim['text']?.toString() ?? '';
        final claimant = claim['claimant']?.toString();
        final claimDate = claim['claimDate']?.toString();

        if (reviews != null && reviews.isNotEmpty) {
          for (final review in reviews) {
            if (review is Map<String, dynamic>) {
              final publisher = review['publisher'] as Map<String, dynamic>?;
              final publisherName = publisher?['name']?.toString() ?? 'Pemeriksa Fakta';
              final publisherSite = publisher?['site']?.toString();
              final reviewTitle = review['title']?.toString() ?? claimText;
              final reviewUrl = review['url']?.toString() ?? '';
              final rating = review['textualRating']?.toString() ?? 'Klaim Diperiksa';
              final reviewDate = review['reviewDate']?.toString();

              results.add(FactCheckModel(
                claimText: claimText,
                claimant: claimant,
                claimDate: claimDate,
                publisherName: publisherName,
                publisherSite: publisherSite,
                reviewTitle: reviewTitle,
                reviewUrl: reviewUrl,
                rating: rating,
                reviewDate: reviewDate,
              ));
            }
          }
        } else {
          results.add(FactCheckModel.fromJson(claim));
        }
      }
    }
    return results;
  }
}

