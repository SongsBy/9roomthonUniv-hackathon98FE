import 'package:flutter/material.dart';
import 'package:remind/model/survey_question_model.dart';
import '../const/color.dart';

// --- 1. 부모 위젯: 상태 관리 및 조립 담당 ---
class SingleSurveyPage extends StatefulWidget {
  final SurveyQuestionModel questionData;
  final int pageIndex;
  final int totalPages;
  final VoidCallback onNextPressed;

  const SingleSurveyPage(
      {required this.questionData,
        required this.pageIndex,
        required this.totalPages,
        required this.onNextPressed,
        super.key});

  @override
  State<SingleSurveyPage> createState() => _SingleSurveyPageState();
}

class _SingleSurveyPageState extends State<SingleSurveyPage> {

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///상단 위젯
        _TopSection(
          imagePath: widget.questionData.imagePath,
          pageIndex: widget.pageIndex,
          totalPages: widget.totalPages,
        ),
        ///설문 위젯
        _SurveySection(
          questionData: widget.questionData,
          selectedIndex: selectedIndex,
          onNextPressed: widget.onNextPressed,
          pageIndex: widget.pageIndex,
          totalPages: widget.totalPages,

          onOptionSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ],
    );
  }
}





///상단위젯
class _TopSection extends StatelessWidget {
  final String imagePath;
  final int pageIndex;
  final int totalPages;

  const _TopSection({
    required this.imagePath,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Column(
      children: [
        SizedBox(height: 80),
        Image.asset(imagePath, width: 150, height: 150),
        SizedBox(height: 20),
        Text(
          '질문 ${pageIndex + 1} / $totalPages',
          style: mediumText?.copyWith(
            color: primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

/// 하단 위젯
typedef OnOptionSelected = void Function(int index);
class _SurveySection extends StatelessWidget {
  final SurveyQuestionModel questionData;
  final int? selectedIndex;
  final OnOptionSelected onOptionSelected;
  final VoidCallback onNextPressed;
  final int pageIndex;
  final int totalPages;

  const _SurveySection({
    required this.questionData,
    required this.selectedIndex,
    required this.onOptionSelected,
    required this.onNextPressed,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = pageIndex == totalPages - 1;
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        decoration: BoxDecoration(
          color: Color(0xFFE3DFFF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questionData.question,
              style: mediumText?.copyWith(
                  fontSize: 19, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Column(
              children: questionData.options.asMap().entries.map((entry) {
                final index = entry.key;
                final optionText = entry.value;

                final defaultStyle = OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                );

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: OutlinedButton(
                    style: defaultStyle.copyWith(
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: selectedIndex == index
                              ? primaryColor
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                    ),
                    onPressed: () {

                      onOptionSelected(index);
                    },
                    child: Text(
                      optionText,
                      style: mediumText?.copyWith(fontSize: 15.7),
                      textAlign: TextAlign.start,
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: Size(double.infinity, 50)),
              onPressed: selectedIndex == null ? null : onNextPressed,
              child:
              Text(
                 isLastPage ? '진단 시작하기' :'다음설문',
                  style: mediumText?.copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}