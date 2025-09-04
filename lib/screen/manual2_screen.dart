import 'package:flutter/material.dart';

import 'manual3_screen.dart';

class Manual2Screen extends StatelessWidget {
  const Manual2Screen({super.key});

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
              'assets/img/Frame2.png',
              width: screenWidth,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 30),
              child: Text(
                '나와 꼭 맞는 페이스메이트를\n우리 동네에서 찾아드릴게요.',
                style: titleLarge?.copyWith(fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: Text(
                '간단한 마음 진단으로 당신의 상태를 파악하고, 나와 비슷한 속도로 함께 걷고 뛸 마음 맞는 동네 친구를 연결해 드려요.',
                style: mediumText?.copyWith(color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 60),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Manual3Screen()));
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
