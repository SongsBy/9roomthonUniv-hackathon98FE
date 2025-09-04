import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SurveyResultSkeleton extends StatelessWidget {
  const SurveyResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    Widget buildGrayBox({
      required double width,
      required double height,
      double radius = 8,
    }) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70),
          buildGrayBox(width: 280, height: 30),
          SizedBox(height: 50),
          SizedBox(
            width: 350,
            child: Card(
              elevation: 16,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildGrayBox(width: 150, height: 24),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [buildGrayBox(width: 250, height: 20)],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: baseColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                        (_) => buildGrayBox(width: 80, height: 40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: buildGrayBox(width: double.infinity, height: 60),
          ),
          SizedBox(height: 20),
          buildGrayBox(width: 280, height: 58, radius: 10),
        ],
      ),
    );
  }
}
