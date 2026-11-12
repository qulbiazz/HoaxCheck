import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../data/datasources/guide_remote_data_source.dart';
import '../../data/models/guide_model.dart';
import '../widgets/guide_header.dart';
import '../widgets/guide_image_banner.dart';
import '../widgets/guide_quote_box.dart';
import '../widgets/guide_principle_card.dart';
import '../widgets/guide_checklist_box.dart';
import '../widgets/guide_action_footer.dart';

class GuideDetailPage extends StatefulWidget {
  final GuideRemoteDataSource? remoteDataSource;

  const GuideDetailPage({super.key, this.remoteDataSource});

  @override
  State<GuideDetailPage> createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends State<GuideDetailPage> {
  late final GuideRemoteDataSource _dataSource;
  List<GuidePrincipleModel> _principles = GuidePrincipleModel.defaultPrinciples;
  GuideContentModel _content = GuideContentModel.defaultContent;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = widget.remoteDataSource ?? GuideRemoteDataSourceImpl();
    _loadGuideData();
  }

  Future<void> _loadGuideData() async {
    try {
      final principlesFuture = _dataSource.getPrinciples();
      final contentFuture = _dataSource.getGuideContent();

      final results = await Future.wait([principlesFuture, contentFuture]);

      if (mounted) {
        setState(() {
          final fetchedPrinciples = results[0] as List<GuidePrincipleModel>;
          if (fetchedPrinciples.isNotEmpty) {
            _principles = fetchedPrinciples;
          }
          _content = results[1] as GuideContentModel;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
      appBar: const GuideHeader(),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _loadGuideData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GuideImageBanner(),
                const SizedBox(height: 20),

                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      ),
                    ),
                  ),

                GuideQuoteBox(quote: _content.quoteText),
                const SizedBox(height: 20),

                ..._principles.map((principle) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: GuidePrincipleCard(
                    stepNumber: principle.stepNumber,
                    title: principle.title,
                    description: principle.description,
                    subPoints: principle.subPoints,
                  ),
                )),

                GuideChecklistBox(
                  title: _content.checklistTitle,
                  subtitle: _content.checklistSubtitle,
                  checklistItems: _content.checklistItems,
                ),
                const SizedBox(height: 20),

                const GuideActionFooter(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
