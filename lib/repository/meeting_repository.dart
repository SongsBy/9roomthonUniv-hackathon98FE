import 'package:dio/dio.dart';
import 'package:remind/model/meeting_detail_model.dart';
import 'package:remind/model/meeting_list_card_model.dart';


List<MeetingDetailModel> _dummyDetails = [
  MeetingDetailModel(
    id: '1',
    title: '같이 농구할 사람!',
    imagePath: 'assets/img/turtle.png',
    time: '오늘 18:00',
    place: '중앙공원 농구장',
    latitude: 37.3351,
    longitude: 126.7285,
    fullDescription: '오늘 저녁 6시에 중앙공원 농구장에서 같이 농구하실 분 구합니다. 초보도 환영!',
  ),
  MeetingDetailModel(
    id: '2',
    title: '저녁 드실 분 구함',
    imagePath: 'assets/img/koala.png',
    time: '오늘 19:00',
    place: 'E동 학생식당',
    latitude: 37.3402,
    longitude: 126.7331,
    fullDescription: 'E동 학생식당에서 7시에 저녁 같이 드실 분 구해요!',
  ),
  MeetingDetailModel(
    id: '3',
    title: 'Flutter 스터디 그룹',
    imagePath: 'assets/img/hedgehog.png',
    time: '매주 토요일 14:00',
    place: 'TIP 1층 카페',
    latitude: 37.3445,
    longitude: 126.7380,
    fullDescription: 'TIP 1층 카페에서 매주 토요일 오후 2시에 모여서 함께 공부합니다. 초보자, 숙련자 모두 환영합니다!',
  ),
];



class MeetingRepository {
  final _dio = Dio();
  final _baseUrl = 'https://[백엔드_서버_주소]';


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


  Future<List<MeetingListCardModel>> fetchMeetingsStatically({
    double? latitude,
    double? longitude,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return  [
      MeetingListCardModel(
        id: '1',
        title: '같이 농구할 사람!',
        imagePath: 'assets/img/turtle.png',
        time: '오늘 18:00',
        place: '중앙공원 농구장',
        latitude: 37.36479,
        longitude: 126.9354,
      ),
      MeetingListCardModel(
        id: '2',
        title: '저녁 드실 분 구함',
        imagePath: 'assets/img/koala.png',
        time: '오늘 19:00',
        place: 'E동 학생식당',
        latitude: 37.35161,
        longitude: 126.9412,
      ),
      MeetingListCardModel(
        id: '3',
        title: 'Flutter 스터디 그룹',
        imagePath: 'assets/img/hedgehog.png',
        time: '매주 토요일 14:00',
        place: 'TIP 1층 카페',
        latitude: 37.3445,
        longitude: 126.7380,
      ),
    ];
  }

  Future<MeetingDetailModel> fetchMeetingDetailsStatically({
    required String id,
  }) async {

    await Future.delayed(const Duration(milliseconds: 500));


    return _dummyDetails.firstWhere(
          (detail) => detail.id == id,

      orElse: () => _dummyDetails.first,
    );
  }
}