
class FeedbackCardModel {
  final String header;
  final String title;
  final String subtitle;

  const FeedbackCardModel({
    required this.header,
    required this.title,
    required this.subtitle,
  });
  factory FeedbackCardModel.empty() {
    return const FeedbackCardModel(header: '', title: '', subtitle: '');
  }
}