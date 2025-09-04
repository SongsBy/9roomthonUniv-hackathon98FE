import 'package:remind/model/survey_question_model.dart';

class SurveyRepository {
  List<SurveyQuestionModel> get questions {
    return [
      SurveyQuestionModel(
          question: '요즘 당신을 가장 힘들게 하는 것은 어떤 종류의 피로감인가요?',
          options:[
            '뭘 해도 재미없고, 집중이 잘 안 돼요.',
            '사소한 일에도 감정이 크게 오르내려요.',
            '충분히 자도 몸이 무겁고 개운하지가 않아요.',
            '사람들을 만나는 게 버겁고 혼자 있고 싶어요.',
          ],
          imagePath: 'assets/img/Octopus.png'
      ),
      SurveyQuestionModel(
          question: '요즘 스트레스를 받을 때,몸은 주로 어떻게 반응하나요?',
          options:[
            '머리가 지끈거리고 생각이 많아져요',
            '어깨와 목 주변이 돌처럼 뭉쳐요.',
            '가슴이 답답하고 숨쉬기 힘들 때가 있어요.',
            '소화가 잘 안되고 속이 더부룩해요.',
          ],
          imagePath: 'assets/img/dinosaur.png'
      ),
      SurveyQuestionModel(
          question: '새로운 사람과 만난다면,어떤 방식의 소통이 가장 편안할까요?',
          options:[
            '많은 대화 없이, 함께 걷는 것만으로도 좋아요.',
            '취미나 흥미로운 주제에 대해 이야기하고 싶어요.',
            '서로의 고민을 들어주고 공감을 나누고 싶어요.',
            '즐거운 농담이나 일상적인 대화를 나누고 싶어요.',
          ],
          imagePath: 'assets/img/turtle.png'
      ),
      SurveyQuestionModel(
          question: '운동 을 통해 지금 당신이가장 되찾고 싶은 감각은 무엇인가요?',
          options:[
            '아무 생각 없이 땀 흘리고 싶어요.',
            '자연을 느끼며 마음을 가라앉히고 싶어요.',
            '작은 목표라도 꾸준히 해내고 싶어요.',
            '누군가와 함께하고 있다는 느낌을 받고 싶어요.',
          ],
          imagePath: 'assets/img/panda.png'
      ),
      SurveyQuestionModel(
          question: '요즘 당신을 가장 힘들게 하는 것은어떤 종류의 피로감인가요?',
          options:[
            '뭘 해도 재미없고, 집중이 잘 안 돼요. ',
            '사소한 일에도 감정이 크게 오르내려요.',
            '충분히 자도 몸이 무겁고 개운하지가 않아요.',
            '사람들을 만나는 게 버겁고 혼자 있고 싶어요.',
          ],
          imagePath: 'assets/img/koala.png'
      ),
    ];
  }
}