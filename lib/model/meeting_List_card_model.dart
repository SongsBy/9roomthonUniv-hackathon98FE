class MeetingListCardModel {
  final String imagePath;
  final String title;
  final String time;
  final String place;

  MeetingListCardModel({
    required this.title,
    required this.imagePath,
    required this.time,
    required this.place,
  });

  // JSON Map을 MeetingListCardModel 객체로 변환
  factory MeetingListCardModel.fromJson(Map<String, dynamic> json) {
    return MeetingListCardModel(
      title: json['title'] ?? '제목 없음',
      imagePath: json['imagePath'] ?? 'assets/img/default.png',
      time: json['time'] ?? '시간 정보 없음',
      place: json['place'] ?? '장소 정보 없음',
    );
  }
}