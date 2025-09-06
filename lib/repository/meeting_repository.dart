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
  // --- 여기에 아래 9~18 항목들을 기존 리스트 끝에 추가 ---
  MeetingDetailModel(
    id: '9',
    title: '카페에서 독서 모임',
    imagePath: 'assets/img/koala.png',
    time: '토요일 15:00',
    place: '연희동 작은카페',
    latitude: 37.5860,
    longitude: 126.9251,
    fullDescription: '조용한 카페에서 가볍게 독서하고 감상 나눠요. 초보 독서모도 환영!',
  ),
  MeetingDetailModel(
    id: '10',
    title: '요가 & 스트레칭',
    imagePath: 'assets/img/turtle.png',
    time: '수요일 19:30',
    place: '창천체육관',
    latitude: 37.5799,
    longitude: 126.9228,
    fullDescription: '하루 피로를 풀어주는 요가와 스트레칭 클래스. 매트만 가져오세요!',
  ),
  MeetingDetailModel(
    id: '11',
    title: '사진 산책',
    imagePath: 'assets/img/hedgehog.png',
    time: '일요일 16:00',
    place: '경의선 숲길 입구(연남)',
    latitude: 37.5829,
    longitude: 126.9280,
    fullDescription: '동네 골목과 숲길을 걸으며 사진 찍는 모임입니다. 카메라/폰 모두 OK.',
  ),
  MeetingDetailModel(
    id: '12',
    title: '콘솔 게임 밤',
    imagePath: 'assets/img/panda.png',
    time: '금요일 21:00',
    place: '연남동 게임라운지',
    latitude: 37.5865,
    longitude: 126.9198,
    fullDescription: '마리오카트/스매시 등 멀티게임 위주로 즐겨요. 간단 스낵 제공!',
  ),
  MeetingDetailModel(
    id: '13',
    title: '영화 같이 보기',
    imagePath: 'assets/img/otter.png',
    time: '토요일 19:00',
    place: '신촌 작은 상영관',
    latitude: 37.5812,
    longitude: 126.9256,
    fullDescription: '소규모 상영 후 감상 토크. 이번 주는 힐링 영화 테마입니다.',
  ),
  MeetingDetailModel(
    id: '14',
    title: '베이킹 클래스',
    imagePath: 'assets/img/Octopus.png',
    time: '일요일 13:00',
    place: '연남 쿠킹스튜디오',
    latitude: 37.5848,
    longitude: 126.9210,
    fullDescription: '쿠키/마들렌 구워봐요! 초보자도 쉽게 따라 할 수 있어요.',
  ),
  MeetingDetailModel(
    id: '15',
    title: '드로잉 모임',
    imagePath: 'assets/img/koala.png',
    time: '화요일 18:30',
    place: '창천동 커뮤니티룸',
    latitude: 37.5809,
    longitude: 126.9167,
    fullDescription: '연필과 스케치북만 들고 오세요. 서로의 작업을 응원합니다.',
  ),
  MeetingDetailModel(
    id: '16',
    title: '등산 계획 회의',
    imagePath: 'assets/img/turtle.png',
    time: '목요일 20:00',
    place: '홍제천 입구',
    latitude: 37.5872,
    longitude: 126.9179,
    fullDescription: '가벼운 트레킹부터 시작해요. 장비 정보/코스 정보 공유합니다.',
  ),
  MeetingDetailModel(
    id: '17',
    title: '러닝 후 브런치',
    imagePath: 'assets/img/panda.png',
    time: '토요일 08:30',
    place: '연남 브런치카페',
    latitude: 37.5853,
    longitude: 126.9237,
    fullDescription: '5km 러닝 후 함께 브런치로 마무리! 초보 페이스 맞춰 드려요.',
  ),
  MeetingDetailModel(
    id: '18',
    title: '보컬 연습',
    imagePath: 'assets/img/hedgehog.png',
    time: '수요일 20:00',
    place: '합주실 B1',
    latitude: 37.5823,
    longitude: 126.9265,
    fullDescription: '발성 워밍업부터 간단 합창까지. 노래 좋아하시는 분 환영합니다!',
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
      // --- 기존 1~8 뒤에 아래 9~18 항목 추가 ---
      MeetingListCardModel(
        id: '9',
        title: '카페에서 독서 모임',
        imagePath: 'assets/img/koala.png',
        time: '토요일 15:00',
        place: '연희동 작은카페',
        latitude: 37.5860,
        longitude: 126.9251,
      ),
      MeetingListCardModel(
        id: '10',
        title: '요가 & 스트레칭',
        imagePath: 'assets/img/turtle.png',
        time: '수요일 19:30',
        place: '창천체육관',
        latitude: 37.5799,
        longitude: 126.9228,
      ),
      MeetingListCardModel(
        id: '11',
        title: '사진 산책',
        imagePath: 'assets/img/hedgehog.png',
        time: '일요일 16:00',
        place: '경의선 숲길 입구(연남)',
        latitude: 37.5829,
        longitude: 126.9280,
      ),
      MeetingListCardModel(
        id: '12',
        title: '콘솔 게임 밤',
        imagePath: 'assets/img/panda.png',
        time: '금요일 21:00',
        place: '연남동 게임라운지',
        latitude: 37.5865,
        longitude: 126.9198,
      ),
      MeetingListCardModel(
        id: '13',
        title: '영화 같이 보기',
        imagePath: 'assets/img/otter.png',
        time: '토요일 19:00',
        place: '신촌 작은 상영관',
        latitude: 37.5812,
        longitude: 126.9256,
      ),
      MeetingListCardModel(
        id: '14',
        title: '베이킹 클래스',
        imagePath: 'assets/img/Octopus.png',
        time: '일요일 13:00',
        place: '연남 쿠킹스튜디오',
        latitude: 37.5848,
        longitude: 126.9210,
      ),
      MeetingListCardModel(
        id: '15',
        title: '드로잉 모임',
        imagePath: 'assets/img/koala.png',
        time: '화요일 18:30',
        place: '창천동 커뮤니티룸',
        latitude: 37.5809,
        longitude: 126.9167,
      ),
      MeetingListCardModel(
        id: '16',
        title: '등산 계획 회의',
        imagePath: 'assets/img/turtle.png',
        time: '목요일 20:00',
        place: '홍제천 입구',
        latitude: 37.5872,
        longitude: 126.9179,
      ),
      MeetingListCardModel(
        id: '17',
        title: '러닝 후 브런치',
        imagePath: 'assets/img/panda.png',
        time: '토요일 08:30',
        place: '연남 브런치카페',
        latitude: 37.5853,
        longitude: 126.9237,
      ),
      MeetingListCardModel(
        id: '18',
        title: '보컬 연습',
        imagePath: 'assets/img/hedgehog.png',
        time: '수요일 20:00',
        place: '합주실 B1',
        latitude: 37.5823,
        longitude: 126.9265,
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