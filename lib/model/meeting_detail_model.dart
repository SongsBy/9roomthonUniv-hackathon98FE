class MeetingDetailModel {
  final String id;
  final String title;
  final String imagePath;
  final String time;
  final String place;
  final double latitude;
  final double longitude;
  final String fullDescription;

  MeetingDetailModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
    required this.fullDescription,
  });

  factory MeetingDetailModel.fromJson(Map<String, dynamic> json) {
    return MeetingDetailModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '제목 없음',
      imagePath: json['imagePath'] ?? 'assets/img/default.png',
      time: json['time'] ?? '시간 정보 없음',
      place: json['place'] ?? '장소 정보 없음',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      fullDescription: json['fullDescription'] ?? '상세 설명이 없습니다.',
    );
  }
}