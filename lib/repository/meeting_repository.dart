import 'package:dio/dio.dart';
import 'package:remind/model/meeting_detail_model.dart';
import 'package:remind/model/meeting_list_card_model.dart';

/// 정적 상세 데이터
final List<MeetingDetailModel> _dummyDetails = [
  MeetingDetailModel(
    id: '1',
    title: '오리고기 먹을사람',
    imagePath: 'assets/img/turtle.png',
    time: '오늘 18:00',
    place: '카타쯔무리 앞',
    latitude: 37.58379,
    longitude: 126.9232,
    fullDescription: '오리 좋아하는 사람 손!!',
  ),
  MeetingDetailModel(
    id: '2',
    title: '저녁 드실 분 구함',
    imagePath: 'assets/img/koala.png',
    time: '오늘 19:00',
    place: 'E동 학생식당',
    latitude: 37.58275,
    longitude: 126.9195,
    fullDescription: 'E동 학생식당에서 7시에 저녁 같이 드실 분 구해요!',
  ),
  MeetingDetailModel(
    id: '3',
    title: 'Flutter 스터디 그룹',
    imagePath: 'assets/img/hedgehog.png',
    time: '매주 토요일 14:00',
    place: 'TIP 1층 카페',
    latitude: 37.58180,
    longitude: 126.9139,
    fullDescription: 'TIP 1층 카페에서 매주 토요일 오후 2시에 모여서 함께 공부합니다. 초보자, 숙련자 모두 환영합니다!',
  ),
  // 추가 더미
  MeetingDetailModel(
    id: '4',
    title: '아침 러닝 같이 하실 분',
    imagePath: 'assets/img/otter.png',
    time: '매주 일요일 07:00',
    place: '한강공원 입구',
    latitude: 37.5805,
    longitude: 126.9200,
    fullDescription: '일요일 아침에 가볍게 5km 러닝합니다. 초보 환영, 끝나고 커피도 한잔해요 ☕',
  ),
  MeetingDetailModel(
    id: '5',
    title: '보드게임 좋아하는 분',
    imagePath: 'assets/img/panda.png',
    time: '토요일 저녁 18:30',
    place: '신촌 보드게임 카페',
    latitude: 37.5832,
    longitude: 126.9221,
    fullDescription: '여러 명이 모여서 보드게임 하고 놀아요! 루미큐브, 다빈치 코드, 스플렌더 등 준비되어 있습니다.',
  ),
  MeetingDetailModel(
    id: '6',
    title: '토익/자격증 스터디',
    imagePath: 'assets/img/Octopus.png',
    time: '매주 화·목 19:00',
    place: '도서관 3층 스터디룸',
    latitude: 37.5820,
    longitude: 126.9185,
    fullDescription: '토익, 자격증 준비 같이 해요. 서로 공부 체크해주고 2시간 집중합니다. 끝나고 간단히 밥도 먹어요.',
  ),
  MeetingDetailModel(
    id: '7',
    title: '버스킹 같이 준비할 분',
    imagePath: 'assets/img/panda.png',
    time: '금요일 20:00',
    place: '홍대 놀이터',
    latitude: 37.5835,
    longitude: 126.9212,
    fullDescription: '기타, 드럼, 보컬 등 악기 가능한 분 환영합니다. 간단히 연습하고 주말에 버스킹 나가봐요 🎸',
  ),
  MeetingDetailModel(
    id: '8',
    title: '밤 산책 번개',
    imagePath: 'assets/img/turtle.png',
    time: '오늘 22:00',
    place: '연세대학교 정문 앞',
    latitude: 37.5840,
    longitude: 126.9240,
    fullDescription: '갑자기 바람 쐬고 싶어서 올려봅니다. 밤 산책 같이 해요!',
  ),
];

class MeetingRepository {
  final _dio = Dio();
  final _baseUrl = 'https://[백엔드_서버_주소]';

  /// 실제 서버 목록 조회
  Future<List<MeetingListCardModel>> fetchMeetings({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/meetings',
        queryParameters: {'lat': latitude, 'lng': longitude, 'radius': 3},
      );
      if (response.data != null && response.data is List) {
        return (response.data as List)
            .map((item) => MeetingListCardModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('모임 목록을 불러오는데 실패했습니다: $e');
      return [];
    }
  }

  /// 실제 서버 상세 조회
  Future<MeetingDetailModel> fetchMeetingDetails({required String id}) async {
    final url = '$_baseUrl/meetings/$id';
    try {
      final response = await _dio.get(url);
      return MeetingDetailModel.fromJson(response.data);
    } catch (e) {
      print('ID($id) 모임의 상세 정보를 불러오는데 실패했습니다: $e');
      throw Exception('상세 정보 로딩 실패');
    }
  }

  /// 정적 목록 조회 (카드용)
  Future<List<MeetingListCardModel>> fetchMeetingsStatically({
    double? latitude,
    double? longitude,
  }) async {
    // UX용 살짝의 로딩
    await Future.delayed(const Duration(milliseconds: 600));

    // 상세 더미와 동일한 id/좌표/제목/시간/장소를 사용하여 일관성 유지
    return [
      MeetingListCardModel(
        id: '1',
        title: '오리고기 먹을사람',
        imagePath: 'assets/img/turtle.png',
        time: '오늘 18:00',
        place: '카타쯔무리 앞',
        latitude: 37.58379,
        longitude: 126.9232,
      ),
      MeetingListCardModel(
        id: '2',
        title: '저녁 드실 분 구함',
        imagePath: 'assets/img/koala.png',
        time: '오늘 19:00',
        place: 'E동 학생식당',
        latitude: 37.58275,
        longitude: 126.9195,
      ),
      MeetingListCardModel(
        id: '3',
        title: 'Flutter 스터디 그룹',
        imagePath: 'assets/img/hedgehog.png',
        time: '매주 토요일 14:00',
        place: 'TIP 1층 카페',
        latitude: 37.58180,
        longitude: 126.9139,
      ),
      MeetingListCardModel(
        id: '4',
        title: '아침 러닝 같이 하실 분',
        imagePath: 'assets/img/otter.png',
        time: '매주 일요일 07:00',
        place: '한강공원 입구',
        latitude: 37.5805,
        longitude: 126.9200,
      ),
      MeetingListCardModel(
        id: '5',
        title: '보드게임 좋아하는 분',
        imagePath: 'assets/img/panda.png',
        time: '토요일 저녁 18:30',
        place: '신촌 보드게임 카페',
        latitude: 37.5832,
        longitude: 126.9221,
      ),
      MeetingListCardModel(
        id: '6',
        title: '토익/자격증 스터디',
        imagePath: 'assets/img/Octopus.png',
        time: '매주 화·목 19:00',
        place: '도서관 3층 스터디룸',
        latitude: 37.5820,
        longitude: 126.9185,
      ),
      MeetingListCardModel(
        id: '7',
        title: '버스킹 같이 준비할 분',
        imagePath: 'assets/img/panda.png',
        time: '금요일 20:00',
        place: '홍대 놀이터',
        latitude: 37.5835,
        longitude: 126.9212,
      ),
      MeetingListCardModel(
        id: '8',
        title: '밤 산책 번개',
        imagePath: 'assets/img/turtle.png',
        time: '오늘 22:00',
        place: '연세대학교 정문 앞',
        latitude: 37.5840,
        longitude: 126.9240,
      ),
    ];
  }

  /// 정적 상세 조회 (카드 → 상세 연결)
  Future<MeetingDetailModel> fetchMeetingDetailsStatically({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _dummyDetails.firstWhere(
          (detail) => detail.id == id,
      orElse: () => _dummyDetails.first,
    );
  }
}