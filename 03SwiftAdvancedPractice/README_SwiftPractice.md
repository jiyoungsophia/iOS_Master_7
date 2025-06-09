# 🎯 Swift Advanced Practice
Swift의 고급 문법과 개념을 학습하기 위한 실습 프로젝트입니다. 클로저, 고차함수, 제네릭, 프로토콜, 에러 핸들링, 객체지향 설계, 메모리 관리 등을 다룹니다.

### 📋 문제 구성
**필수 문제 (5개)**
1. 클로저 기본: 클로저 정의, 타입 명시, 함수 파라미터로 전달
2. 고차함수: map/filter 변환, 체이닝, 커스텀 고차함수 구현
3. 제네릭: 타입별 함수 통합, 제네릭 제약조건 활용
4. 프로토콜: 프로토콜 설계, 다형성, 타입 캐스팅
5. 에러 핸들링: 커스텀 에러, throwing function, do-catch

**도전 문제 (4개)**
1. 객체지향 설계: 상속, 다형성, 접근제어자, 엔진 교체 시스템
2. 고급 제네릭: 제네릭 제약조건, Comparable 프로토콜
3. 프로토콜 확장: extension을 통한 기본 구현 제공
4. 메모리 관리: 순환참조 생성 및 해결, weak/unowned 활용


#### 필요 환경
- macOS
- Xcode 14.0+
- Swift 5.7+

### 폴더 구조
```
02SwiftAdvancedPractice/
├── 📁 Problem4/            # 프로토콜
│   ├── Cat.swift
│   ├── Dog.swift
│   ├── Introducible.swift
│   ├── Introducible+.swift
│   └── Robot.swift
├── 📁 Problem5/            # 에러 핸들링
│   ├── DeliveryError.swift
│   ├── DeliveryStatuc.swift
│   └── DeliverySystme.swift
├── Cars.swift          # 클로저
├── CircularReference.swift
├── Closures.swift
├── Generices.swift
├── HigherOrderFunctions.swift
├── SortableBox.swift           # 제네릭
└── main.swift 
```

### 주요 학습 내용
- 클로저와 고차함수의 실전 활용
- 제네릭을 활용한 타입 안전성 확보
- 프로토콜 기반 설계와 다형성 구현
- Swift 에러 핸들링 패턴 마스터
- 객체지향 설계 원칙 적용
- 메모리 관리와 순환참조 해결
