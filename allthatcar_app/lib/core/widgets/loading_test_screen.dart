import 'package:flutter/material.dart';
import 'custom_loading_indicator.dart';

/// 로딩 인디케이터 테스트 화면
class LoadingTestScreen extends StatefulWidget {
  const LoadingTestScreen({super.key});

  @override
  State<LoadingTestScreen> createState() => _LoadingTestScreenState();
}

class _LoadingTestScreenState extends State<LoadingTestScreen> {
  bool _showFullScreenLoading = false;

  @override
  Widget build(BuildContext context) {
    // 전체 화면 로딩이 활성화되면 로딩만 표시
    if (_showFullScreenLoading) {
      return const Scaffold(
        body: CustomLoadingIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('로딩 인디케이터 테스트'),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 설명 카드
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '로딩 인디케이터 테스트',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'ALL THAT CAR 로고를 사용한 다양한 로딩 인디케이터를 테스트할 수 있습니다.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 전체 화면 로딩 테스트
            _buildTestSection(
              title: '1. 전체 화면 로딩',
              description: '화면 전체를 덮는 로딩 인디케이터',
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showFullScreenLoading = true;
                      });
                      // 3초 후 자동으로 숨김
                      Future.delayed(const Duration(seconds: 3), () {
                        if (mounted) {
                          setState(() {
                            _showFullScreenLoading = false;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('전체 화면 로딩 표시 (3초)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 미리보기
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: const CustomLoadingIndicator(
                        size: 120,
                        message: '데이터 로딩 중...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 오버레이 로딩 테스트
            _buildTestSection(
              title: '2. 오버레이 로딩',
              description: '다이얼로그 형태의 로딩 오버레이',
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      LoadingOverlay.show(
                        context,
                        message: '처리 중입니다...',
                      );
                      // 3초 후 자동으로 숨김
                      Future.delayed(const Duration(seconds: 3), () {
                        if (mounted) {
                          LoadingOverlay.hide(context);
                        }
                      });
                    },
                    icon: const Icon(Icons.layers),
                    label: const Text('오버레이 로딩 표시 (3초)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      LoadingOverlay.show(
                        context,
                        message: '사용자 정의 메시지',
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) {
                          LoadingOverlay.hide(context);
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('커스텀 메시지로 표시'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 다양한 크기 테스트
            _buildTestSection(
              title: '3. 다양한 크기',
              description: '로딩 인디케이터의 크기를 조절할 수 있습니다',
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSizePreview(80, '작은 크기'),
                      _buildSizePreview(120, '중간 크기'),
                      _buildSizePreview(150, '큰 크기'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 배경색 테스트
            _buildTestSection(
              title: '4. 배경색 변경',
              description: '다양한 배경색으로 테스트',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildColorButton(Colors.white, '흰색'),
                  _buildColorButton(Colors.grey[100]!, '회색'),
                  _buildColorButton(const Color(0xFFE3F2FD), '연한 파란색'),
                  _buildColorButton(const Color(0xFF4A90E2), '파란색'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSizePreview(double size, String label) {
    return Column(
      children: [
        Container(
          width: size + 40,
          height: size + 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[50],
          ),
          child: Center(
            child: CustomLoadingIndicator(
              size: size,
              backgroundColor: Colors.grey[50],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildColorButton(Color color, String label) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: color,
              appBar: AppBar(
                title: Text('$label 배경'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: CustomLoadingIndicator(
                backgroundColor: color,
                message: '$label 배경에서 테스트',
              ),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: color == Colors.white || color == Colors.grey[100]
            ? Colors.black
            : Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
      child: Text(label),
    );
  }
}
