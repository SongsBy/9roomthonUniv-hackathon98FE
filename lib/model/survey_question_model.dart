class SurveyQuestionModel{
  final String question;
  final String imagePath;
  final List<String> options;

  SurveyQuestionModel({
    required this.question,
    required this.options,
    required this.imagePath,
});
}