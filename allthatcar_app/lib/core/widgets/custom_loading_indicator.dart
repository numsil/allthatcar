import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// AllThatCar 로고를 사용한 커스텀 로딩 인디케이터
class CustomLoadingIndicator extends StatefulWidget {
  final double size;
  final Color? backgroundColor;
  final String? message;

  const CustomLoadingIndicator({
    super.key,
    this.size = 150.0,
    this.backgroundColor,
    this.message,
  });

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // 밝기 애니메이션 (로고가 숨 쉬듯이 밝기 변화)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.65,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 로고 이미지를 빌드하는 메서드 (SVG 사용, 밝기 애니메이션 적용)
  Widget _buildLogo({required double width, required double height}) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
      builder: (context, child) {
        return Opacity(
          opacity: _pulseAnimation.value,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: widget.backgroundColor ?? Colors.white,
      child: Center(
        child: _buildLogo(
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}

/// 간단한 오버레이 로딩 인디케이터 (다이얼로그 형태)
class LoadingOverlay extends StatelessWidget {
  final String? message;

  const LoadingOverlay({
    super.key,
    this.message,
  });

  /// 로고 이미지를 빌드하는 메서드 (SVG 사용)
  Widget _buildLogo({required double width, required double height}) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      width: width,
      height: height,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => Container(
        width: width,
        height: height,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildLogo(
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }

  /// 로딩 오버레이를 표시하는 헬퍼 메서드
  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingOverlay(message: message),
    );
  }

  /// 로딩 오버레이를 숨기는 헬퍼 메서드
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
