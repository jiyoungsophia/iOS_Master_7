# ⚡️ 해리포터 시리즈 앱 (Harry Potter Series App)
Clean Architecture와 MVVM 패턴을 적용한 iOS 해리포터 시리즈 정보 앱입니다. JSON 데이터를 활용해 7권의 책 정보를 제공하며, 스크롤 뷰와 사용자 상태 저장 기능을 포함합니다.

### 📱 앱 소개
해리포터 시리즈 7권의 상세 정보를 확인할 수 있는 앱입니다.

#### 주요 기능
- 시리즈 선택: 1-7권 버튼으로 원하는 책 정보 조회
- 상태 저장: 앱 종료 후에도 Summary 펼침/접기 상태 유지
- 에러 처리: 데이터 로딩 실패 시 Alert 표시
- 반응형 UI: 다양한 기기 크기 및 방향 대응


#### 기술 스택
- UIKit + SnapKit + Then
- Clean Architecture + MVVM
- Dependency Injection
- JSON, UserDefaults
- XCTest (Unit Tests with Mock Objects)

### 아키텍처 구조
```
Presentation Layer (MVVM)
├── BookViewController ← BookViewModel
└── Custom Views (BookDetailView, SummaryView, etc.)

Domain Layer
├── Book (Entity)
├── BookRepository (Interface)
└── UserDefaultsRepository (Interface)

Data Layer
├── BookRepositoryImp
├── UserDefaultsRepositoryImp
├── JSONDataService
└── BookResponseDTO

Test Layer
├── MockBookRepository
├── MockUserDefaultsRepository
└── _4HarryPotterSeriesTests
```

## 🏗️ Clean Architecture 적용 과정과 의도
단순한 JSON 파일 읽기 앱이지만, **"변화에 대응할 수 있는 구조"**를 목표로 설계했습니다.

### 해결하고자 한 문제들
- 데이터 소스 변경: JSON 파일 → 서버 API로 쉽게 전환, 데이터베이스 전환 시 ViewModel/ViewController 변경 없이 BookRepositoryImp만 수정
- 테스트 용이성: 실제 파일 시스템에 의존하지 않는 단위 테스트
- 책임 분리: 각 레이어가 하나의 명확한 역할만 담당

### 고민한 포인트
- DTO 매핑: 외부 데이터 구조와 내부 비즈니스 모델 분리하고자 했으나, 단순한 JSON 구조에서는 Entity를 직접 매핑했어도 충분하다고 생각합니다. 이번 프로젝트에서는 다소 과도한 패턴이었지만 추후에 복잡한 API 응답 구조에 대비한 패턴 연습으로서 가치가 있다고 생각합니다.
- 전체 구조 설계: 이 프로젝트에서는 "미래의 변화를 대비한 설계"보다는 "현재 요구사항에 적합한 단순한 구조"가 더 적절했을 수 있습니다. 하지만 아키텍처 패턴 학습과 확장 가능한 코드 작성 연습으로서는 충분한 가치가 있었다고 생각합니다.

## 🧪 테스트 구조
### Mock 객체 활용
- MockBookRepository: 테스트용 책 데이터 제공
- MockUserDefaultsRepository: 인메모리 상태 저장 시뮬레이션

### 테스트 케이스

- Summary 펼침/접기 상태 저장 테스트
- 사용자 설정 로딩 기능 검증
- ViewModel 비즈니스 로직 단위 테스트

## 📈 개발 과정

### 단계별 구현 (LV1-LV7)
Lv1: 기본 책 제목 및 시리즈 순서 표시
Lv2: 책 정보 영역 구성 (StackView 활용)
Lv3: Dedication과 Summary 영역 추가
Lv4: UIScrollView 및 목차 구성
Lv5: Summary 접기/더보기 기능 + 상태 저장
Lv6: 시리즈 전체(7권) 선택 기능
Lv7: 다양한 디바이스 및 방향 대응

### 주요 학습 내용
- Clean Architecture: 계층 분리를 통한 유지보수성 향상
- MVVM 패턴: ViewModel을 통한 View와 Model 분리
- 의존성 주입: Protocol 기반 설계로 테스트 가능한 코드 구현
- Custom UI Components: 재사용 가능한 View 컴포넌트 설계
- 에러 처리: 체계적인 에러 핸들링 및 사용자 알림
- 상태 관리: UserDefaults를 활용한 사용자 설정 저장
- Auto Layout: SnapKit을 활용한 반응형 레이아웃
- Test-Driven Development: Mock 객체를 활용한 단위 테스트 작성
