import 'package:flutter/material.dart';
import 'package:remind/model/feedback_card_model.dart';

class FeedbackRepository {
  // getter를 사용해 데이터 리스트를 제공합니다.
  List<FeedbackCardModel> get cardDataList {
    // const를 붙여서 컴파일 시점에 상수로 만듭니다. (성능 최적화)
    return const [
      FeedbackCardModel(
        header: '마음챙김',
        title: '복잡한 생각을 위한 처방전',
        subtitle:
        "오늘은 5분 '바디스캔 명상'으로 머릿속을 비워내 보세요. 긴장된 몸과 마음에 작은 쉼표를 찍어줄 거예요.",
      ),
      FeedbackCardModel(
        header: '신체활동',
        title: '몸을 깨우는 간단한 스트레칭',
        subtitle:
        "가벼운 산책이나 스트레칭은 기분을 전환하는 가장 빠른 방법입니다. 굳어있던 몸에 활력을 불어넣어 주세요.",
      ),
      FeedbackCardModel(
        header: '관계맺기',
        title: '소중한 사람에게 보내는 안부',
        subtitle:
        "가까운 친구나 가족에게 짧은 메시지 하나를 보내보세요. 작은 연결이 큰 힘이 될 수 있습니다.",
      ),
    ];
  }
}