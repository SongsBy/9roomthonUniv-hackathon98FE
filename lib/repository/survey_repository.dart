import 'package:remind/model/survey_question_model.dart';

class SurveyRepository {
  List<SurveyQuestionModel> get questions {
    return [
      SurveyQuestionModel(
        question: '요즘 당신을 가장 힘들게 하는 것은 어떤 종류의 피로감인가요?',
        options: [
          '😐 뭘 해도 재미없고, 집중이 잘 안 돼요.',
          '😵 사소한 일에도 감정이 크게 오르내려요.',
          '💤 충분히 자도 몸이 개운하지가 않아요.',
          '🙈 사람들을 만나는 게 버겁고 함들어요',
        ],
        imagePath: 'assets/img/Octopus.png',
      ),
      SurveyQuestionModel(
        question: '요즘 스트레스를 받을 때, 몸은 주로 어떻게 반응하나요?',
        options: [
          '🤕 머리가 지끈거리고 생각이 많아져요.',
          '💆‍♂️ 어깨와 목 주변이 돌처럼 뭉쳐요.',
          '😮‍💨 가슴이 답답하고 숨쉬기 힘들 때가 있어요.',
          '🤢 소화가 잘 안되고 속이 더부룩해요.',
        ],
        imagePath: 'assets/img/dinosaur.png',
      ),
      SurveyQuestionModel(
        question: '새로운 사람과 만난다면, 어떤 방식의 소통이 가장 편안할까요?',
        options: [
          '🚶 대화 없이, 함께 걷는 것만으로도 좋아요.',
          '🎯 흥미로운 주제에 대해 이야기하고 싶어요.',
          '🤝 고민을 들어주고 공감을 나누고 싶어요.',
          '😊 농담이나 일상적인 대화를 나누고 싶어요.',
        ],
        imagePath: 'assets/img/turtle.png',
      ),
      SurveyQuestionModel(
        question: '운동을 통해 지금 당신이 가장 되찾고 싶은 감각은 무엇인가요?',
        options: [
          '💦 아무 생각 없이 땀 흘리고 싶어요.',
          '🌿 자연을 느끼며 마음을 가라앉히고 싶어요.',
          '📈 작은 목표라도 꾸준히 해내고 싶어요.',
          '👥 누군가 같이 있다는 느낌을 받고 싶어요.',
        ],
        imagePath: 'assets/img/panda.png',
      ),
      SurveyQuestionModel(
        question: '요즘 당신의 상태는 어떤가요?',
        options: [
          '🌞 상쾌하게 눈이 떠지고 활력이 넘쳐요.',
          '😵 아직 피곤하고 정신이 멍해요.',
          '😒 해야 할 일들이 떠올라서 벌써 지쳐요.',
          '🤗 뭔가 좋은 일이 있을 것 같아 설레요.',
        ],
        imagePath: 'assets/img/koala.png',
      ),
    ];
  }
}