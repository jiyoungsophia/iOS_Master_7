# 💸 환율 계산기 앱 (Currency Converter App)
Clean Architecture와 MVVM 패턴을 적용한 iOS 환율 계산기 앱입니다. 실시간 환율 정보를 제공하며, 즐겨찾기와 상태 저장 기능을 포함합니다.

### 📱 앱 소개

#### 주요 기능
- 실시간 환율 조회: Open Exchange Rates API를 통한 최신 환율 정보 제공
- 환율 계산: KRW 기준 다양한 통화로의 환율 계산 기능
- 검색 기능: 통화명/국가명으로 환율 정보 검색
- 즐겨찾기: 자주 사용하는 통화 즐겨찾기 등록/해제
- 환율 트렌드: 이전 대비 환율 상승/하락 표시
- 상태 저장: 앱 종료 후에도 마지막 화면 상태 복원

#### 기술 스택
- UIKit + SnapKit + Then
- Clean Architecture + MVVM + Coordinator Pattern
- CoreData + Network API
- Dependency Injection

### 아키텍처 구조
```
App Layer
├── AppDelegate
├── SceneDelegate
└── MainCoordinator (Navigation Logic)

Presentation Layer (MVVM)
├── ExchangeRateViewController ← ExchangeRateViewModel
├── CalculatorViewController ← CalculatorViewModel
└── Custom Views (ExchangeRateTableViewCell)

Domain Layer
├── ExchangeRate (Entity)
└── Business Logic Models

Data Layer
├── Network
│   ├── ExchangeRateService (API 통신)
│   ├── NetworkClient (네트워크 클라이언트)
│   └── ExchangeRateResponse (Response DTO)
├── CoreData
│   ├── Entities (AppState, ExchangeRateRecord, FavoriteCurrency)
│   └── Managers (각 Entity별 CRUD 매니저)
└── Utils (CurrencyMapping, Constants)
```

## 🔧 핵심 컴포넌트
1. Coordinator Pattern
- MainCoordinator: 화면 전환 로직 관리, 앱 상태 복원 처리

2. Network Layer

- ExchangeRateService: Open Exchange Rates API 통신
- NetworkClient: 재사용 가능한 네트워크 클라이언트 
- 에러 핸들링 및 API 응답 파싱

3. CoreData 관리
- AppState: 마지막 화면 상태 저장
- ExchangeRateRecord: 환율 데이터 및 트렌드 정보 저장
- FavoriteCurrency: 사용자 즐겨찾기 통화 관리

4. ViewModels
- ExchangeRateViewModel: 환율 목록, 검색, 즐겨찾기 로직
- CalculatorViewModel: 환율 계산 로직 및 에러 처리


## 📈 개발 과정

### 단계별 구현 (LV1-LV11)
- LV1: 메인 UI 기초 작업 + 데이터 불러오기 - UILabel, UITableView를 이용한 기본 UI 구성 및 외부 API 환율 데이터 조회
- LV2: 메인 화면의 기본적인 UI 구현 - 환율 정보 화면의 상세 UI 디자인 완성
- LV3: 데이터 필터링 - 통화명, 국가명 등 기준의 데이터 필터링 기능 구현
- LV4: 화면 전환 - 환율 정보 네비게이션 바 영역 구현 및 스와이프를 통한 계산기 화면 전환
- LV5: 실시간 데이터 반영 - 화면에 입력된 금액을 실시간으로 환산하는 계산기 기능 구현
- LV6: View와 로직 분리 - MVVM 패턴을 도입하여 UI와 비즈니스 로직 분리
- LV7: 데이터 저장 및 정렬 - 즐겨찾기 목록 CoreData 저장 및 즐겨찾기 상단 고정 기능
- LV8: 데이터 변화에 따른 UI 반영 - 환율 데이터 이전/이후 비교하여 상승🔼/하락🔽 여부 표시
- LV9: 다크모드 구현 - 정해진 색상을 컴포넌트별로 적용하여 다크모드 지원
- LV10: 앱 상태 저장 및 복원 - 사용자가 마지막에 본 화면을 CoreData에 저장하고 앱 재시작 시 복원
- LV11: 메모리 관리 - 메모리 누수 및 강한 참조 순환 디버깅, Xcode 툴을 활용한 개선 경험 문서화
