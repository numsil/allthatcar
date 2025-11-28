import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                fontSize: 20,
                fontWeight: FontWeight.w700,
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
                return _MonthlyCard(monthData: monthData);
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

  const _MonthlyCard({required this.monthData});

  @override
  Widget build(BuildContext context) {
    final completionRate = monthData.totalCount > 0
        ? (monthData.completedCount / monthData.totalCount * 100).toStringAsFixed(1)
        : '0.0';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
          // 월 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${monthData.month}월',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '완료율 $completionRate%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2196F3),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 통계 정보
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: '전체',
                  value: monthData.totalCount.toString(),
                  color: Colors.grey[700]!,
                ),
              ),
              Expanded(
                child: _StatItem(
                  label: '완료',
                  value: monthData.completedCount.toString(),
                  color: const Color(0xFF4CAF50),
                ),
              ),
              Expanded(
                child: _StatItem(
                  label: '진행중',
                  value: (monthData.totalCount - monthData.completedCount).toString(),
                  color: const Color(0xFFFF9800),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 작업 항목별 통계
          Row(
            children: [
              Expanded(
                child: _DepartmentItem(
                  label: '내부',
                  count: monthData.internalCount,
                  color: const Color(0xFF2196F3),
                ),
              ),
              Expanded(
                child: _DepartmentItem(
                  label: '외부',
                  count: monthData.externalCount,
                  color: const Color(0xFFF44336),
                ),
              ),
              Expanded(
                child: _DepartmentItem(
                  label: '내외부',
                  count: monthData.bothCount,
                  color: const Color(0xFFE91E63),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DepartmentItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _DepartmentItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
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
