import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remind/component/mood_selector.dart';
import 'package:remind/model/energy_stat_bodel.dart';
import 'package:remind/model/feedback_card_model.dart';
import 'package:remind/model/mood_model.dart';
import 'package:remind/repository/FeedbackRepository.dart';
import 'package:remind/screen/meeting_ListScreen.dart';
import '../const/color.dart';


class HomeScreen extends StatefulWidget {
  final EnergyStat resultData;

  const HomeScreen({
    required this.resultData,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Mood? _selectedMood;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _feedbackKey = GlobalKey();
  bool _isProcessing = false;
  List<FeedbackCardModel> _feedbackData = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onMoodSelected(Mood mood) async {
    if (_isProcessing) return;

    setState(() {
      _selectedMood = mood;
      _isProcessing = true;
      _feedbackData = [];
    });

    await Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      _feedbackKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );

    await Future.delayed(const Duration(seconds: 1));

    final repository = GetIt.I<FeedbackRepository>();
    final feedbacks = repository.cardDataList;

    setState(() {
      _feedbackData = feedbacks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0XFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///상단 프로필 카드
              _TopProfile(resultData: widget.resultData),
              ///기분 선택 위젯
              _MoodSelectionSection(
                isProcessing: _isProcessing,
                onMoodSelected: onMoodSelected,
              ),
                ///주변 모임 버튼
                _Button(onPressed: onMeetingPressed),
                SizedBox(height: 50),
              Padding(
                key: _feedbackKey,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                /// 기분 클릭시 피드백 카드 섹션
                _FeedbackSection(
                    feedbackData:
                    _feedbackData),
              ),
               SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
  void onMeetingPressed(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MeetingListscreen()));
  }
}














/// 상단 프로필 카드
class _TopProfile extends StatelessWidget {
  final EnergyStat resultData;
  const _TopProfile({required this.resultData, super.key});

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Text(
            '송정훈 님의 마음 프로필',
            style: mediumText?.copyWith(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
        Center(
          child: SizedBox(
            width: 350,
            height: 400,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              elevation: 14,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(resultData.characterImagePath, width: 170, height: 170),
                   SizedBox(height: 20),
                  Text(
                    resultData.characterName,
                    textAlign: TextAlign.center,
                    style: mediumText?.copyWith(
                        fontSize: 24, color: Color(0XFF6D7AC9), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 기분 선택 위젯
class _MoodSelectionSection extends StatelessWidget {
  final bool isProcessing;
  final OnMoodSelected onMoodSelected;
  const _MoodSelectionSection({required this.isProcessing, required this.onMoodSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: AbsorbPointer(
        absorbing: isProcessing,
        child: MoodSelector(
          onMoodSelected: onMoodSelected,
        ),
      ),
    );
  }
}

/// 모임 가긱 버튼
class _Button extends StatelessWidget {
  final VoidCallback onPressed;
  const _Button({
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final baseButtonStyle = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: baseButtonStyle,
          padding: EdgeInsets.symmetric(horizontal: 134, vertical: 17),
        ),
        onPressed: onPressed,
        child: Text(
          '내 주면 모임',
          style: (mediumText ?? const TextStyle(fontSize: 20)).copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


/// 피드백 카드 섹션
class _FeedbackSection extends StatelessWidget {
  final List<FeedbackCardModel> feedbackData;
  const _FeedbackSection({required this.feedbackData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          duration:  Duration(milliseconds: 500),
          opacity: feedbackData.isNotEmpty ? 1.0 : 0.0,
          child: _FeedbackCard(
              data: feedbackData.isNotEmpty ? feedbackData[0] : FeedbackCardModel.empty()),
        ),
         SizedBox(height: 16),
        AnimatedOpacity(
          duration:  Duration(milliseconds: 500),
          curve:  Interval(0.3, 1.0),
          opacity: feedbackData.length > 1 ? 1.0 : 0.0,
          child: _FeedbackCard(
              data: feedbackData.length > 1 ? feedbackData[1] : FeedbackCardModel.empty()),
        ),
         SizedBox(height: 16),
        AnimatedOpacity(
          duration:  Duration(milliseconds: 500),
          curve:  Interval(0.6, 1.0),
          opacity: feedbackData.length > 2 ? 1.0 : 0.0,
          child: _FeedbackCard(
              data: feedbackData.length > 2 ? feedbackData[2] : FeedbackCardModel.empty()),
        ),
      ],
    );
  }
}

/// 피드백 카드 구성
class _FeedbackCard extends StatelessWidget {
  final FeedbackCardModel data;
  const _FeedbackCard({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.header,
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              data.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              data.subtitle,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}