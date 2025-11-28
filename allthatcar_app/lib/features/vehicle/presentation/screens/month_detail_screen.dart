import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'vehicle_detail_screen.dart';

/// 월별 전체 차량 목록 화면 (주차 필터 없음)
class MonthDetailScreen extends StatefulWidget {
  final String siteName;
  final int month;

  const MonthDetailScreen({
    super.key,
    required this.siteName,
    required this.month,
  });

  @override
  State<MonthDetailScreen> createState() => _MonthDetailScreenState();
}

class _MonthDetailScreenState extends State<MonthDetailScreen> {
  List<Vehicle> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _vehicles = _getMonthVehicles();
  }

  // 해당 월의 모든 차량 데이터 가져오기
  List<Vehicle> _getMonthVehicles() {
    final allVehicles = _getMockVehicles();
    return allVehicles.where((vehicle) {
      final month = int.parse(vehicle.date.split('/')[0]);
      return month == widget.month;
    }).toList();
  }

  // 임시 차량 데이터 (vehicle_list_screen.dart와 동일)
  List<Vehicle> _getMockVehicles() {
    return [
      // 9월 데이터
      Vehicle(id: '1', plateNumber: '10가1234', model: '그랜저', department: '내부', date: '9/1', isCompleted: true),
      Vehicle(id: '2', plateNumber: '11가1234', model: 'GV80', department: '내외부', date: '9/3', isCompleted: true),
      Vehicle(id: '3', plateNumber: '10가4321', model: '쏘나타', department: '외부', date: '9/5', isCompleted: true),
      Vehicle(id: '4', plateNumber: '10가6234', model: 'GV80', department: '내부', date: '9/7', isCompleted: true),
      Vehicle(id: '5', plateNumber: '10나1234', model: '그랜저', department: '외부', date: '9/10', isCompleted: true),
      Vehicle(id: '6', plateNumber: '10가1111', model: '쏘나타', department: '내부', date: '9/12', isCompleted: false),
      Vehicle(id: '7', plateNumber: '12가5678', model: 'GV70', department: '내외부', date: '9/15', isCompleted: true),
      Vehicle(id: '8', plateNumber: '13가9012', model: '그랜저', department: '외부', date: '9/18', isCompleted: true),
      Vehicle(id: '9', plateNumber: '14가3456', model: 'GV80', department: '내부', date: '9/20', isCompleted: false),
      Vehicle(id: '10', plateNumber: '15가7890', model: '쏘나타', department: '내외부', date: '9/22', isCompleted: true),
      Vehicle(id: '11', plateNumber: '16가1122', model: 'GV70', department: '외부', date: '9/25', isCompleted: true),
      Vehicle(id: '12', plateNumber: '17가3344', model: '그랜저', department: '내부', date: '9/28', isCompleted: false),

      // 10월 데이터
      Vehicle(id: '13', plateNumber: '18가5566', model: 'GV80', department: '내외부', date: '10/2', isCompleted: true),
      Vehicle(id: '14', plateNumber: '19가7788', model: '쏘나타', department: '외부', date: '10/5', isCompleted: true),
      Vehicle(id: '15', plateNumber: '20가9900', model: 'GV70', department: '내부', date: '10/8', isCompleted: false),
      Vehicle(id: '16', plateNumber: '21가1357', model: '그랜저', department: '내외부', date: '10/10', isCompleted: true),
      Vehicle(id: '17', plateNumber: '22가2468', model: 'GV80', department: '외부', date: '10/12', isCompleted: true),
      Vehicle(id: '18', plateNumber: '23가3579', model: '쏘나타', department: '내부', date: '10/15', isCompleted: true),
      Vehicle(id: '19', plateNumber: '24가4680', model: 'GV70', department: '내외부', date: '10/18', isCompleted: false),
      Vehicle(id: '20', plateNumber: '25가5791', model: '그랜저', department: '외부', date: '10/20', isCompleted: true),
      Vehicle(id: '21', plateNumber: '26가6802', model: 'GV80', department: '내부', date: '10/22', isCompleted: true),
      Vehicle(id: '22', plateNumber: '27가7913', model: '쏘나타', department: '내외부', date: '10/25', isCompleted: false),
      Vehicle(id: '23', plateNumber: '28가8024', model: 'GV70', department: '외부', date: '10/28', isCompleted: true),
      Vehicle(id: '24', plateNumber: '29가9135', model: '그랜저', department: '내부', date: '10/30', isCompleted: true),

      // 11월 데이터
      Vehicle(id: '25', plateNumber: '30가1246', model: 'GV80', department: '내외부', date: '11/1', isCompleted: true),
      Vehicle(id: '26', plateNumber: '31가2357', model: '쏘나타', department: '외부', date: '11/3', isCompleted: false),
      Vehicle(id: '27', plateNumber: '32가3468', model: 'GV70', department: '내부', date: '11/5', isCompleted: true),
      Vehicle(id: '28', plateNumber: '33가4579', model: '그랜저', department: '내외부', date: '11/8', isCompleted: true),
      Vehicle(id: '29', plateNumber: '34가5680', model: 'GV80', department: '외부', date: '11/10', isCompleted: false),
      Vehicle(id: '30', plateNumber: '35가6791', model: '쏘나타', department: '내부', date: '11/12', isCompleted: true),
      Vehicle(id: '31', plateNumber: '36가7802', model: 'GV70', department: '내외부', date: '11/15', isCompleted: true),
      Vehicle(id: '32', plateNumber: '37가8913', model: '그랜저', department: '외부', date: '11/18', isCompleted: false),
      Vehicle(id: '33', plateNumber: '38가9024', model: 'GV80', department: '내부', date: '11/20', isCompleted: true),
      Vehicle(id: '34', plateNumber: '39가0135', model: '쏘나타', department: '내외부', date: '11/22', isCompleted: true),
      Vehicle(id: '35', plateNumber: '40가1246', model: 'GV70', department: '외부', date: '11/25', isCompleted: false),
      Vehicle(id: '36', plateNumber: '41가2357', model: '그랜저', department: '내부', date: '11/28', isCompleted: true),
    ];
  }

  Color _getDepartmentColor(String department) {
    switch (department) {
      case '내부':
        return const Color(0xFF2196F3);
      case '외부':
        return const Color(0xFF4CAF50);
      case '내외부':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 차량 목록
          Expanded(
            child: _vehicles.isEmpty
                ? const Center(
                    child: Text(
                      '등록된 차량이 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _vehicles.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),
                    itemBuilder: (context, index) {
                      final vehicle = _vehicles[index];
                      return _VehicleCard(
                        vehicle: vehicle,
                        siteName: widget.siteName,
                        getDepartmentColor: _getDepartmentColor,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final String siteName;
  final Color Function(String) getDepartmentColor;

  const _VehicleCard({
    required this.vehicle,
    required this.siteName,
    required this.getDepartmentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Row(
          children: [
            // 날짜
            SizedBox(
              width: 50,
              child: Text(
                vehicle.date,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // 차량 정보 (좌측)
            Expanded(
              child: Row(
                children: [
                  Text(
                    vehicle.plateNumber,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    vehicle.model,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (vehicle.isCompleted) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '완료',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // 작업 항목 (우측)
            Text(
              vehicle.department == '내외부' ? '내외' : vehicle.department,
              style: TextStyle(
                fontSize: 13,
                color: getDepartmentColor(vehicle.department),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
    );
  }
}

/// 차량 정보 모델 (vehicle_list_screen.dart와 동일)
class Vehicle {
  final String id;
  final String plateNumber;
  final String model;
  final String department;
  final String date;
  final bool isCompleted;

  Vehicle({
    required this.id,
    required this.plateNumber,
    required this.model,
    required this.department,
    required this.date,
    this.isCompleted = false,
  });
}
