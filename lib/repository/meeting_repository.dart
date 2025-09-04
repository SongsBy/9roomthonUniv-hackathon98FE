import 'package:dio/dio.dart';
import 'package:remind/model/meeting_list_card_model.dart';

class MeetingRepository {
  final _dio = Dio();
  final _targetUrl = 'https://[백엔드_서버_주소]/meetings';

  // // --- 1. 실제 API를 호출하는 함수 ---
  // Future<List<MeetingListCardModel>> fetchMeetingsFromApi() async {
  //   try {
  //     final response = await _dio.get(_targetUrl);
  //
  //     if (response.data != null && response.data is List) {
  //       return (response.data as List)
  //           .map((item) => MeetingListCardModel.fromJson(item))
  //           .toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     print('모임 목록을 불러오는데 실패했습니다: $e');
  //     return [];
  //   }
  // }

  // --- 2. 하드코딩된 정적 데이터를 제공하는 함수 ---
  Future<List<MeetingListCardModel>> fetchMeetingsStatically() async {
    // 실제 네트워크 통신처럼 보이도록 잠시 지연
    await Future.delayed(const Duration(seconds: 1));

    return  [
      MeetingListCardModel(
        title: '같이 농구할 사람!',
        imagePath: 'assets/img/turtle.png',
        time: '오늘 18:00',
        place: '중앙공원 농구장',
      ),
      MeetingListCardModel(
        title: '저녁 드실 분 구함',
        imagePath: 'assets/img/koala.png',
        time: '오늘 19:00',
        place: 'E동 학생식당',
      ),
      MeetingListCardModel(
        title: 'Flutter 스터디 그룹',
        imagePath: 'assets/img/hedgehog.png',
        time: '매주 토요일 14:00',
        place: 'TIP 1층 카페',
      ),
    ];
  }
}