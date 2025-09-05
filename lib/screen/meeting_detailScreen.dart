import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remind/const/color.dart';
import 'package:remind/model/meeting_detail_model.dart';
import 'package:remind/repository/meeting_repository.dart';

class MeetingDetailScreen extends StatefulWidget {
  final String meetingId;

  const MeetingDetailScreen({
    required this.meetingId,
    super.key,
  });

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  late final Future<MeetingDetailModel> meetingDetailFuture;

  @override
  void initState() {
    super.initState();
    meetingDetailFuture = GetIt.I<MeetingRepository>()
        .fetchMeetingDetailsStatically(id: widget.meetingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
        title:  Text('모임 상세', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<MeetingDetailModel>(
        future: meetingDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('상세 정보를 불러올 수 없습니다.'));
          }

          final detailData = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _TopSection(detail: detailData),
                  const SizedBox(height: 24),
                  _MiddleSection(detail: detailData),
                  const SizedBox(height: 24),
                  _BottomSection(detail: detailData),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _JoinButton(),
    );
  }
}


class _TopSection extends StatelessWidget {
  final MeetingDetailModel detail;
  const _TopSection({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(detail.imagePath, height: 100),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('모임장: 꼬끼오'),
            Icon(Icons.verified, color: Colors.orange, size: 16),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE3DFFF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            detail.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}


class _MiddleSection extends StatelessWidget {
  final MeetingDetailModel detail;
  const _MiddleSection({required this.detail});

  @override
  Widget build(BuildContext context) {

    final timeParts = detail.time.split(' ');
    final date = timeParts.isNotEmpty ? timeParts[0] : '정보없음';
    final startTime = timeParts.length > 1 ? timeParts[1] : '정보없음';


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _InfoBox(title: '모임 날짜', value: date),
            const SizedBox(width: 8),
            _InfoBox(title: '모임 시간', value: startTime),
            const SizedBox(width: 8),
            const _InfoBox(title: '종료 시간', value: '21:00'),
          ],
        ),
        const SizedBox(height: 16),
        const Text('모임 장소', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(detail.place),
      ],
    );
  }
}


class _BottomSection extends StatelessWidget {
  final MeetingDetailModel detail;
  const _BottomSection({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('모임 소개', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text(detail.fullDescription),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          const _InfoTile(icon: Icons.people, text: '제한없음'),
          const _InfoTile(icon: Icons.male, text: '성별 구분없음'),
          const _InfoTile(icon: Icons.chat_bubble_outline, text: '뒷풀이 있음'),
        ],
      ),
    );
  }
}



class _InfoBox extends StatelessWidget {
  final String title;
  final String value;
  const _InfoBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('함께하기'),
      ),
    );
  }
}