# remind

## 🌱 Remind – 감정 기반 소셜 모임 추천 서비스

- 오늘의 감정 컬러에 맞는 피드백과 주변 모임을 연결해주는 감정·소셜 헬스케어 앱
현대인의 일상은 감정 기복과 피로 누적으로 인해 사회적 연결 단절을 초래하기 쉽습니다.
Remind는 사용자의 감정 상태(퍼스널 컬러) 를 기반으로:
	•	긍정적인 피드백 제공
	•	감정에 맞는 활동 추천
	•	사용자의 위치 기반 주변 소셜 모임 탐색

까지 지원하는 감정 관리 + 커뮤니티 매칭 플랫폼입니다.
## 구조
- lib

- main.dart
- Model
  - agreement_model.dart
  - energy_stat_model.dart
  - feedback_card_model.dart
  - meeting_datail_model.dart
  - meeting_List_card_model.dart
  - mood_model.dart
  - signin_field_model.dart
  - survey_question_model.dart
- component
  - feedback_card.dart
  - mood_selector.dart
  - single_survey_result_sleleton.dart
- repository
  - FeedbackRepository.dart
  - meeting_repository.dart
  - signin_repository.dart
  - survey_repository.dart
  - survey_resilt_repoistory.dart
- screen
  - HomeScreen.dart
  - login_screen.dart
  - meeting_detailScreen.dart
  - meeting_ListScreen.dart
  - signinScreen.dart
  - splash_screen.dart
  - stratGate_screen.dart
  - survey_screen.dart
  - type_setting_gate_screen.dart
- const
  - color.dart
- core
  - app_theme_controller.dart
 
## Useed Plugin
- get_it
- shimmer
- google_maps_flutter
- geolocator
- slidong_up_panel
- dio
