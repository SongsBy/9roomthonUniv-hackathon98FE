# 🌱 Remind – 감정 기반 소셜 모임 추천 서비스

오늘의 감정 컬러에 맞는 피드백과 주변 모임을 연결해주는 **감정·소셜 헬스케어 앱**

---

## 📌 프로젝트 개요
현대인의 일상은 감정 기복과 피로 누적으로 인해 사회적 연결 단절을 초래하기 쉽습니다.  
**Remind**는 사용자의 감정 상태(퍼스널 컬러)를 기반으로:

- 긍정적인 피드백 제공  
- 감정에 맞는 활동 추천  
- 사용자의 위치 기반 주변 소셜 모임 탐색  

까지 지원하는 **감정 관리 + 커뮤니티 매칭 플랫폼**입니다.

---

## ✨ 주요 기능

### 1. 감정 퍼스널 컬러 선택
- 하루의 감정을 색상(컬러칩)으로 표현  
- 선택한 컬러에 따라 앱 전체의 분위기(UI 배경 색상)가 자연스럽게 변환  
- 색상에 따른 긍정적인 한마디 피드백 제공  

### 2. 감정 설문 (온보딩)
- 간단한 질문/답변으로 현재 감정 상태 진단  
- 진행바, 일러스트, 이모지 기반 옵션으로 직관적인 UI 제공  

### 3. 감정 프로필
- 설문 결과를 캐릭터 + 이름으로 시각화  
- `"000 님의 마음 프로필"` 처럼 개인화된 결과 화면  

### 4. 피드백 카드
- 오늘 감정에 맞춘 2~3개의 피드백 카드 제공  
- 감정 케어 문구, 추천 활동, 자기돌봄 팁  

### 5. 모임 탐색 (지도 기반)
- Google Maps + Geolocator 를 사용하여 반경 3km 내 모임 탐색  
- 더미 데이터 + 서버 연동 구조 준비  
- 슬라이딩 패널 UI → 모임 리스트 표시  
- 모임 카드 리디자인: 썸네일, 장소, 시간, **"자세히 보기" 버튼**  

### 6. 모임 상세
- 카드 클릭 시 상세 화면 이동  
- 모임 설명, 시간/장소, 참여 정보  

---
## 📂 프로젝트 구조
```
lib/
├── main.dart                  # 앱 진입점
├── model/                     # 데이터 모델 정의
│    ├── agreement_model.dart
│    ├── energy_stat_model.dart
│    ├── feedback_card_model.dart
│    ├── meeting_detail_model.dart
│    ├── meeting_list_card_model.dart
│    ├── mood_model.dart
│    ├── signin_field_model.dart
│    └── survey_question_model.dart
│
├── component/                 # 재사용 가능한 위젯 컴포넌트
│    ├── feedback_card.dart
│    ├── mood_selector.dart
│    └── single_survey_result_skeleton.dart
│
├── repository/                # 데이터 및 API 통신 레이어
│    ├── feedback_repository.dart
│    ├── meeting_repository.dart
│    ├── signin_repository.dart
│    ├── survey_repository.dart
│    └── survey_result_repository.dart
│
├── screen/                    # 주요 화면
│    ├── home_screen.dart
│    ├── login_screen.dart
│    ├── meeting_detail_screen.dart
│    ├── meeting_list_screen.dart
│    ├── signin_screen.dart
│    ├── splash_screen.dart
│    ├── start_gate_screen.dart
│    ├── survey_screen.dart
│    └── type_setting_gate_screen.dart
│
├── const/                     # 공통 상수 및 스타일
│    └── color.dart
│
└── core/                      # 앱 핵심 로직 (DI, 테마 등)
└── app_theme_controller.dart
```
---
## 🛠️ 기술 스택

### Frontend
- Flutter (Dart)  
- **UI 라이브러리**  
---

## 🔌 사용된 주요 플러그인 (Dependencies)

- **[get_it](https://pub.dev/packages/get_it)** → 의존성 주입 (DI) 컨테이너  
- **[shimmer](https://pub.dev/packages/shimmer)** → 로딩 상태 애니메이션 효과  
- **[google_maps_flutter](https://pub.dev/packages/google_maps_flutter)** → 지도 UI 렌더링  
- **[geolocator](https://pub.dev/packages/geolocator)** → 위치 정보 및 거리 계산  
- **[sliding_up_panel](https://pub.dev/packages/sliding_up_panel)** → 지도 위 패널 슬라이딩 UI  
- **[dio](https://pub.dev/packages/dio)** → HTTP 클라이언트 (API 통신)  

---

👉 이렇게 `README.md`에 추가하면 프로젝트의 구조와 기술 스택을 심사위원이나 협업자들이 빠르게 이해할 수 있어요.  

혹시 제가 **프로젝트 개요 + 주요 기능 + 폴더 구조 + 사용 플러그인**을 모두 합쳐서 하나의 완성된 README 템플릿으로 만들어드릴까요?

### Backend (Mock 기반 준비)
- Node.js / Spring (연동 예정)  
- 현재는 **Dio + 더미 JSON 기반 mock data**  

### Infra
- GitHub (코드 관리)  
- iOS Simulator / Android Emulator  

---

## 📱 구현 화면 (예시)
- 감정 설문 화면  
- 프로필 캐릭터  
- 퍼스널 컬러 선택 → 배경색 변환  
- 주변 모임 지도 + 카드 리스트  
- 모임 상세 페이지  

(📸 스크린샷 / GIF 추가 예정)

---

## 🚀 설치 & 실행 방법

```bash
# 저장소 클론
git clone https://github.com/username/remind.git

# 패키지 설치
flutter pub get

# iOS 실행
flutter run -d ios

# Android 실행
flutter run -d android
