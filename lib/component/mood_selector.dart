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
    Mood(label: '매우 좋아요', color: Colors.green, moodText: '최고의 하루! 이 기분 만끽해요.'),
    Mood(label: '좋아요', color: Colors.lightGreen, moodText: '	수고했어요, 당신의 멋진 하루!'),
    Mood(label: '보통', color: Colors.amber,moodText: '무탈한 하루, 잠시 숨을 골라보세요.'),
    Mood(label: '나빠요', color: Colors.orange, moodText: '힘든 하루였죠? 당신 탓이 아니에요.'),
    Mood(label: '매우 나빠요', color: Colors.red, moodText: '억지로 힘내지 않아도 괜찮아요.'),
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