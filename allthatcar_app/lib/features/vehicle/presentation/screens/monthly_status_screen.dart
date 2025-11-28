import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'month_detail_screen.dart';

/// 월별 작업 현황 화면
class MonthlyStatusScreen extends StatelessWidget {
  final String siteName;
  final List<MonthlyData> monthlyDataList;

  const MonthlyStatusScreen({
    super.key,
    required this.siteName,
    required this.monthlyDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              siteName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // TODO: 메뉴 처리
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              '월별 작업 현황',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: monthlyDataList.length,
              itemBuilder: (context, index) {
                final monthData = monthlyDataList[index];
                return _MonthlyCard(
                  monthData: monthData,
                  siteName: siteName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyCard extends StatelessWidget {
  final MonthlyData monthData;
  final String siteName;

  const _MonthlyCard({
    required this.monthData,
    required this.siteName,
  });

  @override
  Widget build(BuildContext context) {
    final completionRate = monthData.totalCount > 0
        ? (monthData.completedCount / monthData.totalCount * 100).toStringAsFixed(1)
        : '0.0';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 월 정보 & 완료율
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${monthData.month}월',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                '완료율 $completionRate%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2196F3),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 통계 정보 (가로 배치)
          Row(
            children: [
              _CompactStatItem(
                label: '전체',
                value: monthData.totalCount.toString(),
                color: Colors.grey[700]!,
              ),
              const SizedBox(width: 16),
              _CompactStatItem(
                label: '완료',
                value: monthData.completedCount.toString(),
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 16),
              _CompactStatItem(
                label: '진행중',
                value: (monthData.totalCount - monthData.completedCount).toString(),
                color: const Color(0xFFFF9800),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 작업 항목별 통계 (가로 배치)
          Row(
            children: [
              _CompactDepartmentItem(
                label: '내부',
                count: monthData.internalCount,
                color: const Color(0xFF2196F3),
              ),
              const SizedBox(width: 8),
              _CompactDepartmentItem(
                label: '외부',
                count: monthData.externalCount,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 8),
              _CompactDepartmentItem(
                label: '내외부',
                count: monthData.bothCount,
                color: const Color(0xFFF44336),
              ),
              const Spacer(),
              // 상세보기 버튼
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MonthDetailScreen(
                        siteName: siteName,
                        month: monthData.month,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: const Text(
                  '상세보기',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompactStatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _CompactStatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _CompactDepartmentItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CompactDepartmentItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// 월별 데이터 모델
class MonthlyData {
  final int month;
  final int totalCount;
  final int completedCount;
  final int internalCount;
  final int externalCount;
  final int bothCount;

  MonthlyData({
    required this.month,
    required this.totalCount,
    required this.completedCount,
    required this.internalCount,
    required this.externalCount,
    required this.bothCount,
  });
}
