import 'package:flutter/material.dart';
import 'package:remind/screen/login_screen.dart';
import 'package:remind/screen/type_setting_gate_screen.dart';

class Manual3Screen extends StatelessWidget {
  const Manual3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/Frame3.png',
              width: screenWidth,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 30),
              child: Text(
                '몸과 마음이 무겁고,\n왠지 모르게 혼자인 것 같나요?',
                style: titleLarge?.copyWith(fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: Text(
                '움직일 에너지가 부족한 날,\n혼자서 시작하기 막막할 때가 있죠.\n괜찮아요, 당신만 그런 게 아니에요.',
                style: mediumText?.copyWith(color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => TypeSettingGateScreen()));
                    },
                    icon: Image.asset('assets/img/Button.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
