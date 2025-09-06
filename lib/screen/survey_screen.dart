// lib/screen/survey_screen.dart
import 'package:flutter/material.dart';
import 'package:remind/const/color.dart';
import 'package:remind/model/survey_question_model.dart';
import 'package:remind/repository/survey_repository.dart';
import 'package:remind/screen/survey_result_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final questions = SurveyRepository().questions;
  int index = 0;
  final Map<int, int> selections = {};

  Future<bool> _handleBack() async {
    if (index > 0) {
      setState(() => index -= 1);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final total = questions.length;
    final q = questions[index];
    final progress = total == 0 ? 0.0 : (index + 1) / total;
    final mediumText = Theme.of(context).textTheme.displayMedium;

    return WillPopScope(
      onWillPop: _handleBack,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('성향 분석', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final pop = await _handleBack();
              if (pop && context.mounted) Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
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
                const SizedBox(height: 16),

                // 캐릭터 이미지(고정)
                Center(
                  child: Image.asset(
                    q.imagePath,
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(height: 12),


                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 380),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, anim) {
                      final inTween = Tween<Offset>(
                        begin: const Offset(0.12, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeOut));
                      return FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: anim.drive(inTween),
                          child: child,
                        ),
                      );
                    },
                    child: _SurveyCard(
                      key: ValueKey(index),
                      question: q,
                      selectedIndex: selections[index],
                      onSelect: (opt) {
                        setState(() {
                          selections[index] = opt;
                        });
                      },
                      onNext: () {
                        if (!selections.containsKey(index)) return;
                        if (index < total - 1) {
                          setState(() => index += 1);
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const SurveyResultScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SurveyCard extends StatelessWidget {
  final SurveyQuestionModel question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  const _SurveyCard({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3DFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text(
            question.question,
            textAlign: TextAlign.center,
            style: mediumText?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),


          Expanded(
            child: Column(
              children: List.generate(4, (i) {
                final hasOption = i < question.options.length;
                final text = hasOption ? question.options[i] : '';
                final isSelected = (selectedIndex == i) && hasOption;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(
                          color: hasOption
                              ? (isSelected ? primaryColor : Colors.grey.shade300)
                              : Colors.grey.shade200,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: hasOption ? () => onSelect(i) : null,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: mediumText?.copyWith(
                            fontSize: 15.5,
                            color: hasOption ? Colors.black : Colors.grey.shade400,
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
                  selectedIndex! >= question.options.length)
                  ? null
                  : onNext,
              child: Text(
                '다음 설문',
                style: mediumText?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}