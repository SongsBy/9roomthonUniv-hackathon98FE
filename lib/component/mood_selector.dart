import 'package:flutter/material.dart';

import '../model/mood_model.dart';


typedef OnMoodSelected = void Function(Mood selectedMood);

class MoodSelector extends StatefulWidget {
  final OnMoodSelected onMoodSelected;

  const MoodSelector({
    required this.onMoodSelected,
    super.key,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  final List<Mood> moods =  [
    Mood(label: '매우 좋아요', color: 	Color(0xFFB2DFDB), moodText: '당신의 맑은 에너지가 주위를 밝히네요!'),
    Mood(label: '좋아요', color: Color(0xFFFFE0B2), moodText: '따뜻한 마음 덕분에 오늘이 더욱 포근해요.'),
    Mood(label: '보통', color: Color(0xFFD1C4E9),moodText: '당신의 깊은 매력이 빛나고 있어요.'),
    Mood(label: '나빠요', color: Color(0xFFB3E5FC), moodText: '시원한 매력이 모두에게 힘을 주네요.'),
    Mood(label: '매우 나빠요', color: Color(0xFFCFD8DC), moodText: '차분한 당신 덕분에 세상이 안정돼 보여요.'),
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedIndex == null ? '오늘 감정의 퍼스널 컬러는 무엇인가요?' : moods[selectedIndex!].moodText,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 80,
          child: Card(
            color: Colors.white,
            elevation: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: moods.asMap().entries.map((entry) {
                final index = entry.key;
                final mood = entry.value;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onMoodSelected(mood);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: mood.color,
                      shape: BoxShape.circle,
                      border: selectedIndex == index
                          ? Border.all(color: Colors.black54, width: 3.0)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}