# Custom Loading Indicator 사용 가이드

AllThatCar 로고를 사용한 커스텀 로딩 인디케이터입니다.

## 📁 파일 위치
- 위젯: `lib/core/widgets/custom_loading_indicator.dart`
- 로고 이미지: `assets/images/logo.png`

## 🎨 사용 방법

### 1. 전체 화면 로딩 (CustomLoadingIndicator)

```dart
import 'package:allthatcar_app/core/widgets/custom_loading_indicator.dart';

// 기본 사용
Scaffold(
  body: CustomLoadingIndicator(),
)

// 크기와 배경색 커스터마이즈
Scaffold(
  body: CustomLoadingIndicator(
    size: 120.0,
    backgroundColor: Colors.white,
  ),
)
```

### 2. 오버레이 로딩 (LoadingOverlay)

다이얼로그 형태로 표시되는 로딩 인디케이터입니다.

```dart
import 'package:allthatcar_app/core/widgets/custom_loading_indicator.dart';

// 로딩 표시
LoadingOverlay.show(context);

// 메시지와 함께 로딩 표시
LoadingOverlay.show(
  context,
  message: '데이터를 불러오는 중...',
);

// 로딩 숨기기
LoadingOverlay.hide(context);
```

### 3. 비동기 작업 예제

```dart
Future<void> loadData() async {
  // 로딩 시작
  LoadingOverlay.show(context, message: '데이터 로딩 중...');

  try {
    // 비동기 작업 수행
    await Future.delayed(Duration(seconds: 2));
    final data = await fetchData();

    // 로딩 종료
    LoadingOverlay.hide(context);

    // 결과 처리
    setState(() {
      this.data = data;
    });
  } catch (e) {
    // 로딩 종료
    LoadingOverlay.hide(context);

    // 에러 처리
    showErrorDialog(context, e.toString());
  }
}
```

## ✨ 기능

### CustomLoadingIndicator
- ✅ 로고 이미지 크기 조절 애니메이션
- ✅ 페이드 인/아웃 효과
- ✅ 회전하는 CircularProgressIndicator
- ✅ 이미지 로드 실패 시 폴백 아이콘 표시

### LoadingOverlay
- ✅ 반투명 배경 오버레이
- ✅ 카드 형태의 로딩 UI
- ✅ 선택적 메시지 표시
- ✅ 간편한 show/hide 헬퍼 메서드

## 🎯 애니메이션 상세

- **Duration**: 1.5초 (왕복)
- **Scale**: 0.8 ~ 1.2 (크기 변화)
- **Opacity**: 0.5 ~ 1.0 (투명도 변화)
- **Curve**: easeInOut (부드러운 애니메이션)

## 📝 참고사항

1. **이미지 필수**: `assets/images/logo.png` 파일이 있어야 합니다
2. **pubspec.yaml**: assets 경로가 등록되어 있어야 합니다
3. **에러 처리**: 이미지 로드 실패 시 자동으로 폴백 아이콘이 표시됩니다
