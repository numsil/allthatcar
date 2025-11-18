# AllThatCar App

Flutter 기반 사용자 앱 + Supabase 백엔드

## 프로젝트 구조

```
lib/
├── core/                    # 핵심 설정 및 유틸리티
│   ├── config/             # 앱 설정 (Supabase 등)
│   ├── constants/          # 상수 정의
│   └── utils/              # 유틸리티 함수
├── features/               # 기능별 모듈
│   ├── auth/              # 인증 기능
│   │   ├── data/          # 데이터 레이어
│   │   ├── domain/        # 비즈니스 로직
│   │   └── presentation/  # UI 레이어
│   └── home/              # 홈 기능
│       ├── data/
│       ├── domain/
│       └── presentation/
└── shared/                 # 공유 컴포넌트
    ├── widgets/           # 재사용 가능한 위젯
    ├── models/            # 공통 데이터 모델
    └── providers/         # Riverpod 프로바이더
```

## 기술 스택

- **Framework**: Flutter 3.32.8
- **State Management**: Riverpod 2.6.1
- **Backend**: Supabase
- **Navigation**: Go Router 14.6.2
- **Environment**: flutter_dotenv 5.2.1

## 설정 방법

### 1. 환경 변수 설정

`.env.example` 파일을 `.env`로 복사하고 Supabase 정보를 입력하세요:

```bash
cp .env.example .env
```

`.env` 파일 내용:
```
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 2. 의존성 설치

```bash
flutter pub get
```

### 3. 앱 실행

```bash
flutter run
```

## Supabase 프로젝트 설정

1. [Supabase](https://supabase.com) 에서 프로젝트 생성
2. Settings > API 에서 URL과 anon key 확인
3. `.env` 파일에 정보 입력

## 주요 패키지

- `supabase_flutter`: Supabase 클라이언트
- `flutter_riverpod`: 상태 관리
- `go_router`: 네비게이션
- `flutter_dotenv`: 환경 변수 관리
- `shared_preferences`: 로컬 저장소

## 개발 가이드

### Clean Architecture

프로젝트는 Clean Architecture 원칙을 따릅니다:

- **Presentation Layer**: UI 및 상태 관리
- **Domain Layer**: 비즈니스 로직
- **Data Layer**: 데이터 소스 및 Repository

### 코드 스타일

```bash
flutter analyze
```

## 다음 단계

- [ ] 인증 기능 구현 (로그인/회원가입)
- [ ] 홈 화면 UI 구성
- [ ] Supabase 데이터베이스 연동
- [ ] 네비게이션 라우팅 설정
