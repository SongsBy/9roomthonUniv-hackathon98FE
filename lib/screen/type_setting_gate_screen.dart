import 'package:flutter/material.dart';
import 'package:remind/screen/login_screen.dart';
import 'package:remind/screen/survey_screen.dart';

import '../const/color.dart';

class TypeSettingGateScreen extends StatelessWidget {
  const TypeSettingGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                paddingY(40.0),

                ///중단
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _Top(textTheme: textTheme),
                ),
                paddingY(20),

                ///상단
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _Middle()),
                paddingY(90.0),

                ///하단 버튼
                _Bottom(
                  textTheme: textTheme,
                  onPressed: () => _navigateToLogin(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 벼튼 클릭시 동작 함수
void _navigateToLogin(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (BuildContext context) => SurveyScreen()));
}

/// 패딩 함수
Widget paddingY(double value) => SizedBox(height: value);




///상단 텍스트
class _Top extends StatelessWidget {
  final TextTheme textTheme;
  const _Top({required this.textTheme, super.key});

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    final Large = Theme.of(context).textTheme.displayLarge;

    return Column(
      children: [
        Image.asset('assets/img/survey.png')
      ],
    );
  }
}

/// 중단 이미지
class _Middle extends StatelessWidget {
  const _Middle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset('assets/img/Octopus.png'),
    );
  }
}

///하단 버튼
class _Bottom extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onPressed;

  const _Bottom({
    required this.textTheme,
    required this.onPressed,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final baseButtonStyle = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: baseButtonStyle,
            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 17),
          ),
          onPressed: onPressed,
          child: Text(
            '좋아요',
            style: (textTheme.displayMedium ?? const TextStyle(fontSize: 20))
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}