import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remind/component/survey_result_skeleton.dart';
import 'package:remind/model/energy_stat_bodel.dart';
import 'package:remind/repository/survey_result_repository.dart';
import 'package:remind/screen/homescreen.dart';

import '../const/color.dart';

class StatData {
  final Color color;
  final int value;

  StatData({required this.color, required this.value});
}

class SurveyResultScreen extends StatefulWidget {
  const SurveyResultScreen({super.key});

  @override
  State<SurveyResultScreen> createState() => _SurveyResultScreenState();
}

class _SurveyResultScreenState extends State<SurveyResultScreen> {
  late final Future<EnergyStat> surveyResultFuture;
  @override
  @override
  void initState() {
    super.initState();
    surveyResultFuture = GetIt.I<SurveyResultRepository>().getSurveyResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFAFA),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder<EnergyStat>(
              future: surveyResultFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  ///로딩 UI
                  return const SurveyResultSkeleton();
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text('데이터를 불러오는데 실패 했습니다'));
                }

                final resultData = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///상단 텍스트
                    _TopText(),

                    ///감정 캐릭터 카드 섹션
                    _CardSection(resultData: resultData),
                    SizedBox(height: 20.0),

                    /// 하단 설명글 섹션
                    _BottomSection(
                      resultData: resultData,
                      onNextPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) => HomeScreen(resultData: resultData)));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

///상단 텍스트 위젯
class _TopText extends StatelessWidget {
  const _TopText({super.key});

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          '"당신의 마음에 귀 기울여봤어요"',
          style: mediumText?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

/// 카드 섹션
class _CardSection extends StatelessWidget {
  final EnergyStat resultData;

  const _CardSection({required this.resultData, super.key});

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final List<StatData> stats = [
      StatData(
        color: const Color(0XFF27B3AA),
        value: resultData.mindEnergyValue,
      ),
      StatData(
        color: const Color(0XFFCDD2FD),
        value: resultData.bodyEnergyValue,
      ),
      StatData(
        color: const Color(0XFFECECEC),
        value: resultData.relationEnergyValue,
      ),
    ];

    return SizedBox(
      width: 350,
      child: Card(
        elevation: 16,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '당신의 감정 캐릭터',
                style: mediumText?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/img/arrowLeft.png',
                    width: 40,
                    height: 40,
                  ),
                  Expanded(
                    child: Text(
                      resultData.characterName,
                      style: mediumText,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Image.asset(
                    'assets/img/arrowRight.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
              Center(
                child: Image.asset(
                  resultData.characterImagePath,
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text('마음에너지'), Text('신체활력'), Text('관계 에너지')],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: stats
                    .map(
                      (e) => Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: e.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text('${e.value}%'),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 하단섹션
class _BottomSection extends StatelessWidget {
  final EnergyStat resultData;
  final VoidCallback onNextPressed;

  const _BottomSection({
    required this.resultData,
    required this.onNextPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final baseButtonStyle = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(26.0),
          child: Text(
            resultData.explanationText ?? '결과 설명이 없습니다.',
            textAlign: TextAlign.center,
            style: mediumText?.copyWith(color: Colors.grey, fontSize: 18),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: baseButtonStyle,
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 17),
          ),
          onPressed: onNextPressed,
          child: Text('시작하기', style: mediumText?.copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}
