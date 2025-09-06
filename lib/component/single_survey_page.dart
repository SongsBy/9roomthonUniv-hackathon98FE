import 'package:flutter/material.dart';
import 'package:remind/model/survey_question_model.dart';
import '../const/color.dart';


class SingleSurveyPage extends StatefulWidget {
  final SurveyQuestionModel questionData;
  final int pageIndex;
  final int totalPages;
  final VoidCallback onNextPressed;

  const SingleSurveyPage({
    required this.questionData,
    required this.pageIndex,
    required this.totalPages,
    required this.onNextPressed,
    super.key,
  });

  @override
  State<SingleSurveyPage> createState() => _SingleSurveyPageState();
}

class _SingleSurveyPageState extends State<SingleSurveyPage> {
  int? selectedIndex;
  final List<String> imagePaths = [
    'assets/img/hedgehog.png',
    'assets/img/Octopus.png',
    'assets/img/koala.png',
    'assets/img/panda.png',
    'assets/img/turtle.png',
  ];
  @override
  Widget build(BuildContext context) {
    final progress =
    widget.totalPages == 0 ? 0.0 : (widget.pageIndex + 1) / widget.totalPages;
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final currentImage = imagePaths[widget.pageIndex % imagePaths.length];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('성향 분석'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 10,
                  backgroundColor: const Color(0xFFEAE6FF),
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(currentImage,width: 120,height: 120,),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3DFFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 질문
                      Text(
                        widget.questionData.question,
                        textAlign: TextAlign.center,
                        style: mediumText?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 18),


                      Expanded(
                        child: Column(
                          children: List.generate(4, (i) {
                            // 옵션이 4개보다 적을 경우 빈 칸을 비활성으로 채움
                            final hasOption =
                                i < widget.questionData.options.length;
                            final text = hasOption
                                ? widget.questionData.options[i]
                                : '';
                            final selected = selectedIndex == i && hasOption;

                            return Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 6.0),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    side: BorderSide(
                                      color: hasOption
                                          ? (selected
                                          ? primaryColor
                                          : Colors.grey.shade300)
                                          : Colors.grey.shade200,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: hasOption
                                      ? () => setState(() => selectedIndex = i)
                                      : null,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      text,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: mediumText?.copyWith(
                                        fontSize: 15.5,
                                        color: hasOption
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // 다음 버튼
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: (selectedIndex == null ||
                              selectedIndex! >=
                                  widget.questionData.options.length)
                              ? null
                              : widget.onNextPressed,
                          child: Text(
                            '다음 설문',
                            style:
                            mediumText?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}