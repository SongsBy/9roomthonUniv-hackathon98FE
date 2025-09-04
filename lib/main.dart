import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remind/model/meeting_List_card_model.dart';
import 'package:remind/repository/FeedbackRepository.dart';
import 'package:remind/repository/meeting_repository.dart';
import 'package:remind/repository/signin_repository.dart';
import 'package:remind/repository/survey_result_repository.dart';
import 'package:remind/screen/homescreen.dart';
import 'package:remind/screen/splash_screen.dart';

final getIt = GetIt.instance;

void setupLocator (){
  getIt.registerSingleton<SigninRepository>(SigninRepository());
  getIt.registerSingleton<SurveyResultRepository>(SurveyResultRepository());
  getIt.registerSingleton<FeedbackRepository>(FeedbackRepository());
  getIt.registerSingleton<MeetingRepository>(MeetingRepository());
}

void main() {
  setupLocator();
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Pretendard',
            textTheme: TextTheme(
                displayLarge: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                displayMedium: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 16,
                ),

                titleLarge: TextStyle(
                    fontFamily: 'Krub',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                )
            ),
          ),
    home: SplashScreen()
  ));
}