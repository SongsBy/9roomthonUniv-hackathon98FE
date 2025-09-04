// lib/component/feedback_card.dart
import 'package:flutter/material.dart';
import '../model/feedback_card_model.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackCardModel data;

  const FeedbackCard({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.header,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              data.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              data.subtitle,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}