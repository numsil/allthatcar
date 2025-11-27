import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'vehicle_detail_screen.dart';

/// 차량 정보 모델
class Vehicle {
  final String id;
  final String plateNumber;
  final String department;
  final String date;

  Vehicle({
    required this.id,
    required this.plateNumber,
    required this.department,
    required this.date,
  });
}

class VehicleListScreen extends StatefulWidget {
  final String siteName;

  const VehicleListScreen({
    super.key,
    required this.siteName,
  });

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  String _selectedMonth = '2025 7월';

  // 임시 차량 데이터
  List<Vehicle> _getMockVehicles() {
    return [
      Vehicle(
        id: '1',
        plateNumber: '10가1234',
        department: '내부',
        date: '7/1',
      ),
      Vehicle(
        id: '2',
        plateNumber: '11가1234',
        department: '내외부',
        date: '7/1',
      ),
      Vehicle(
        id: '3',
        plateNumber: '10가4321',
        department: '외부',
        date: '7/1',
      ),
      Vehicle(
        id: '4',
        plateNumber: '10가6234',
        department: '내부',
        date: '7/1',
      ),
      Vehicle(
        id: '5',
        plateNumber: '10나1234',
        department: '외부',
        date: '7/1',
      ),
      Vehicle(
        id: '6',
        plateNumber: '10가1111',
        department: '내부',
        date: '7/1',
      ),
    ];
  }

  Color _getDepartmentColor(String department) {
    switch (department) {
      case '내부':
        return const Color(0xFF2196F3); // 파란색
      case '외부':
        return const Color(0xFF4CAF50); // 녹색
      case '내외부':
        return const Color(0xFFE91E63); // 분홍색
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = _getMockVehicles();

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
              widget.siteName,
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
        children: [
          // 월 선택 드롭다운
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // TODO: 월 선택 다이얼로그
                  },
                  child: Row(
                    children: [
                      Text(
                        _selectedMonth,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 차량 목록
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: vehicles.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return _VehicleCard(
                  vehicle: vehicle,
                  departmentColor: _getDepartmentColor(vehicle.department),
                  siteName: widget.siteName,
                );
              },
            ),
          ),

          // 더 보기 버튼
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              onPressed: () {
                // TODO: 더 많은 차량 로드
              },
              child: const Text(
                '더 보기',
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // 달력 보기 버튼
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 달력 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('달력 보기'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '달력 보기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final Color departmentColor;
  final String siteName;

  const _VehicleCard({
    required this.vehicle,
    required this.departmentColor,
    required this.siteName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 차량 상세 화면으로 이동
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VehicleDetailScreen(
              siteName: siteName,
              plateNumber: vehicle.plateNumber,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            // 날짜
            SizedBox(
              width: 40,
              child: Text(
                vehicle.date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 차량 번호 및 부서
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.plateNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vehicle.department,
                    style: TextStyle(
                      fontSize: 14,
                      color: departmentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
