# ⚾ 숫자야구게임 (Baseball Game)
Swift로 구현한 콘솔 기반 숫자야구게임입니다. Protocol 기반 아키텍처와 SOLID 원칙을 적용한 학습 프로젝트입니다.

### 🎮 게임 소개
3자리 숫자를 맞추는 추리 게임입니다.

- 컴퓨터가 생성한 3자리 숫자를 맞춰보세요
- 각 자리의 숫자와 위치가 모두 맞으면 스트라이크
- 숫자는 맞지만 위치가 틀리면 볼
- 힌트를 보고 정답을 찾아보세요!


#### 게임 규칙

- 3자리 숫자 (100 ~ 987)
- 첫 번째 자리는 0이 될 수 없음
- 중복되는 숫자 없음
- 스트라이크와 볼 힌트 제공


#### 필요 환경
- macOS
- Xcode 14.0+
- Swift 5.7+

### 폴더 구조
```
02BaseballGame/
├── 📁 Protocols/           # 인터페이스 정의
│   ├── GameLogicInterface.swift
│   └── RecordManagingInterface.swift
├── 📁 Domain/              # 비즈니스 로직 구현
│   ├── BaseballGame.swift
│   ├── BaseballGameLogic.swift
│   └── RecordManager.swift
├── 📁 Resources/           # 상수 및 설정
│   └── Constants.swift
└── main.swift             # 애플리케이션 진입점
```

### 의존성 관계
```
BaseballGame
├── GameLogicInterface ← BaseballGameLogic
└── RecordManagingInterface ← RecordManager
```


### 파일 상세
1. BaseballGame.swift
- 콘솔 기반 사용자 인터페이스와 게임 플로우 제어
- 사용자의 메뉴 선택에 따라 게임 시작, 기록 보기, 종료 등을 처리
- 핵심 로직은 `GameLogicInterface`, 기록 관리는 `RecordManagingInterface`를 통해 주입받음

2. BaseballGameLogic.swift
- 3자리 정답을 무작위로 생성 `makeAnswer`
- 입력값이 유효한지 확인 `validateInput`
- 사용자 입력과 정답을 비교하여 힌트 반환 `getHint`
- 모든 상수는 Constants 파일로 분리

3. RecordManager.swift
- `addRecord`를 통해 시도 횟수 저장
- `showRecords`를 통해 기록 출력 (없을 시 안내 메시지)

4. Constants.swift
- 메뉴 번호, 출력 메시지, 설정값(자릿수, 범위 등)을 한 곳에서 관리

5. GameLogicInterface.swift / RecordManagingInterface.swift
- 프로토콜 기반 설계를 통해 유닛 테스트, 구조 확장, 모듈화에 유리




## 📈 개발 과정

### 단계별 리팩토링
1. **기본 기능 구현**: 동작하는 야구게임 완성
2. **상수 추출**: 매직 넘버 제거 및 중앙 관리
3. **Protocol 도입**: 인터페이스 기반 설계로 전환
4. **의존성 주입**: 느슨한 결합 구조 구현

### 주요 학습 내용
- Swift Protocol의 활용
- 의존성 주입 패턴 구현
- SOLID 원칙 실습
- 테스트 가능한 코드 설계

