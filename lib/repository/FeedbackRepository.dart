import 'package:flutter/material.dart';
import 'package:remind/model/feedback_card_model.dart';
import 'package:remind/model/mood_model.dart';

class FeedbackRepository {

  final Map<String, List<FeedbackCardModel>> _feedbackData = {
    '매우 좋아요': const [
      FeedbackCardModel(header: '에너지 활용', title: '창의적인 활동은 어떠세요?', subtitle: '넘치는 에너지를 그림 그리기나 글쓰기 같은 창의적인 활동으로 표현해보세요.'),
      FeedbackCardModel(header: '관계맺기', title: '이 기쁨을 함께 나눠보세요', subtitle: '소중한 사람에게 전화해 이 좋은 기분을 나누면 행복이 두 배가 될 거예요.'),
      FeedbackCardModel(header: '미래 계획', title: '새로운 목표를 세워볼까요?', subtitle: '기분이 좋을 때는 긍정적인 계획을 세우기 가장 좋은 타이밍입니다.'),
    ],
    '좋아요': const [
      FeedbackCardModel(header: '신체활동', title: '가벼운 산책 즐기기', subtitle: '좋은 날씨를 느끼며 15분 정도 산책하며 기분을 더 끌어올려 보세요.'),
      FeedbackCardModel(header: '감사하기', title: '오늘의 감사한 일 떠올리기', subtitle: '하루 중 감사했던 작은 순간 세 가지를 떠올려보면 마음이 더 따뜻해질 거예요.'),
      FeedbackCardModel(header: '관계맺기', title: '소중한 사람에게 보내는 안부', subtitle: '가까운 친구나 가족에게 짧은 메시지 하나를 보내보세요. 작은 연결이 큰 힘이 될 수 있습니다.'),
    ],
    '보통': const [
      FeedbackCardModel(header: '마음챙김', title: '좋아하는 음악 감상하기', subtitle: '잔잔한 음악을 들으며 잠시 생각의 흐름을 멈추고 현재에 집중해보세요.'),
      FeedbackCardModel(header: '정리하기', title: '작은 공간 정리 정돈하기', subtitle: '책상 위나 방의 작은 한구석을 정리하는 것만으로도 마음에 안정을 가져올 수 있습니다.'),
      FeedbackCardModel(header: '신체활동', title: '간단한 스트레칭하기', subtitle: '굳어있던 몸을 부드럽게 풀어주면 기분 전환에 도움이 됩니다.'),
    ],
    '나빠요': const [
      FeedbackCardModel(header: '마음챙김', title: '따뜻한 차 한 잔의 여유', subtitle: '좋아하는 차를 마시며 잠시 창밖을 바라보세요. 생각보다 큰 위로가 될 수 있습니다.'),
      FeedbackCardModel(header: '감정일기', title: '지금 드는 생각 적어보기', subtitle: '복잡한 감정을 짧게라도 글로 적어보면 마음을 정리하는 데 도움이 됩니다.'),
      FeedbackCardModel(header: '자연보기', title: '하늘이나 식물 바라보기', subtitle: '잠시 시선을 멀리 두고 자연의 색을 바라보는 것은 눈과 마음에 휴식을 줍니다.'),
    ],
    '매우 나빠요': const [
      FeedbackCardModel(header: '마음챙김', title: '깊고 편안한 호흡 3번 하기', subtitle: '눈을 감고, 코로 천천히 숨을 들이마시고 입으로 길게 내뱉는 심호흡을 해보세요.'),
      FeedbackCardModel(header: '휴식하기', title: '가장 편한 공간에서 휴식하기', subtitle: '오늘은 모든 것을 잠시 멈추고, 스스로에게 아무것도 하지 않을 자유를 주세요.'),
      FeedbackCardModel(header: '자기위로', title: '스스로에게 다정한 말 건네기', subtitle: '스스로를 탓하지 마세요. "힘들었구나", "애썼다"고 다정하게 말해주세요.'),
    ],
  };


  List<FeedbackCardModel> getFeedbacksForMood(Mood mood) {
    return _feedbackData[mood.label] ?? _feedbackData['보통']!;
  }
}