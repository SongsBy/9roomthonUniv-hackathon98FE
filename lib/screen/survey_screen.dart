import 'package:flutter/material.dart';
import 'package:remind/component/single_survey_page.dart';
import 'package:remind/const/color.dart';
import 'package:remind/repository/survey_repository.dart';
import 'package:remind/screen/homescreen.dart';
import 'package:remind/screen/survey_result_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final controller = PageController();
  final repository = SurveyRepository();
  late final question  = repository.questions;

  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
          controller: controller,
          itemCount: question.length,
          itemBuilder: (context , index){
            return SingleSurveyPage(
                questionData: question[index],
                pageIndex: index,
                totalPages: question.length,
                onNextPressed: (){
                  if(index == question.length -1) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SurveyResultScreen()));
                  } else {
                    controller.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.easeOutQuint);
                  }
                }
            );
          }
      ),
    );
  }
}
