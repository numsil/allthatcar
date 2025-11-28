import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'vehicle_detail_screen.dart';
import 'monthly_status_screen.dart';

/// 차량 정보 모델
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
  int _selectedYear = 2025;
  int _selectedMonth = 7;
  int _selectedWeek = 1;
  List<Vehicle> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _vehicles = _getMockVehicles();
  }

  // 임시 차량 데이터 (9월~11월)
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
        return const Color(0xFF2196F3); // 파란색
      case '외부':
        return const Color(0xFF4CAF50); // 녹색
      case '내외부':
        return const Color(0xFFE91E63); // 분홍색
      default:
        return Colors.grey;
    }
  }

  // 선택된 월과 주차에 맞는 차량만 필터링
  List<Vehicle> _getFilteredVehicles() {
    return _vehicles.where((vehicle) {
      // 날짜가 '-'인 경우는 항상 표시
      if (vehicle.date == '-') return true;

      // 월 필터링
      final parts = vehicle.date.split('/');
      if (parts.isEmpty) return false;

      final vehicleMonth = int.tryParse(parts[0]);
      if (vehicleMonth == null || vehicleMonth != _selectedMonth) {
        return false;
      }

      // 주차 필터링 (간단한 날짜 기반)
      if (parts.length > 1) {
        final day = int.tryParse(parts[1]);
        if (day != null) {
          // 1주차: 1-7일, 2주차: 8-14일, 3주차: 15-21일, 4주차: 22일 이상
          final weekStart = (_selectedWeek - 1) * 7 + 1;
          final weekEnd = _selectedWeek * 7;

          if (day < weekStart || day > weekEnd) {
            return false;
          }
        }
      }

      return true;
    }).toList();
  }

  // 월별 통계 데이터 계산
  List<MonthlyData> _calculateMonthlyStats() {
    final vehicles = _getMockVehicles();
    final Map<int, List<Vehicle>> vehiclesByMonth = {};

    // 월별로 차량 그룹화
    for (var vehicle in vehicles) {
      final month = int.parse(vehicle.date.split('/')[0]);
      vehiclesByMonth.putIfAbsent(month, () => []).add(vehicle);
    }

    // 월별 통계 생성
    return vehiclesByMonth.entries.map((entry) {
      final month = entry.key;
      final monthVehicles = entry.value;

      return MonthlyData(
        month: month,
        totalCount: monthVehicles.length,
        completedCount: monthVehicles.where((v) => v.isCompleted).length,
        internalCount: monthVehicles.where((v) => v.department == '내부').length,
        externalCount: monthVehicles.where((v) => v.department == '외부').length,
        bothCount: monthVehicles.where((v) => v.department == '내외부').length,
      );
    }).toList()..sort((a, b) => a.month.compareTo(b.month));
  }

  // 월별 현황 화면으로 이동
  void _navigateToMonthlyStatus() {
    final monthlyStats = _calculateMonthlyStats();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MonthlyStatusScreen(
          siteName: widget.siteName,
          monthlyDataList: monthlyStats,
        ),
      ),
    );
  }

  // 월 드롭다운 메뉴 표시
  void _showMonthMenu(BuildContext context, Offset position) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx - 40,
        position.dy + 10,
        overlay.size.width - position.dx - 40,
        overlay.size.height - position.dy - 10,
      ),
      constraints: const BoxConstraints(
        maxHeight: 300,
        minWidth: 100,
      ),
      items: List.generate(12, (index) => index + 1)
          .map((month) => PopupMenuItem<int>(
                value: month,
                height: 40,
                child: Text(
                  '${month}월',
                  style: const TextStyle(fontSize: 14),
                ),
              ))
          .toList(),
    ).then((selectedMonth) {
      if (selectedMonth != null) {
        setState(() {
          _selectedMonth = selectedMonth;
        });
      }
    });
  }

  // 주차 드롭다운 메뉴 표시
  void _showWeekMenu(BuildContext context, Offset position) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + 30,
        position.dx + 200,
        position.dy + 300,
      ),
      items: List.generate(4, (index) => index + 1)
          .map((week) => PopupMenuItem<int>(
                value: week,
                child: Text('${week}주차'),
              ))
          .toList(),
    ).then((selectedWeek) {
      if (selectedWeek != null) {
        setState(() {
          _selectedWeek = selectedWeek;
        });
      }
    });
  }

  void _showDeleteConfirmDialog(Vehicle vehicle, int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 아이콘
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),

              // 제목
              const Text(
                '차량 삭제',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // 차량 정보
              Text(
                '${vehicle.plateNumber} · ${vehicle.model}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),

              // 버튼들
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _vehicles.removeAt(index);
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('삭제되었습니다'),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                      ),
                      child: const Text(
                        '삭제',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddVehicleDialog() {
    final plateNumberController = TextEditingController();
    final modelController = TextEditingController();
    final dateController = TextEditingController();
    String selectedDepartment = '내부';

    // 날짜 자동 포맷팅 함수
    void formatDateInput(String value) {
      String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (digitsOnly.length > 8) {
        digitsOnly = digitsOnly.substring(0, 8);
      }

      String formatted = '';
      if (digitsOnly.length >= 1) {
        formatted = digitsOnly.substring(0, digitsOnly.length > 4 ? 4 : digitsOnly.length);
        if (digitsOnly.length > 4) {
          formatted += '.${digitsOnly.substring(4, digitsOnly.length > 6 ? 6 : digitsOnly.length)}';
          if (digitsOnly.length > 6) {
            formatted += '.${digitsOnly.substring(6)}';
          }
        }
      }

      dateController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue[50]!,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.directions_car,
                        color: Color(0xFF2196F3),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '작업 등록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 현장 (좌우 배치)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '현장',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      widget.siteName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 차량번호
                TextField(
                  controller: plateNumberController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: '차량번호',
                    labelStyle: const TextStyle(fontSize: 13),
                    hintText: '예: 10가1234',
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF2196F3),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // 차량 모델
                TextField(
                  controller: modelController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: '차량 모델',
                    labelStyle: const TextStyle(fontSize: 13),
                    hintText: '예: 그랜저, GV80',
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF2196F3),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // 날짜
                TextField(
                  controller: dateController,
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number,
                  onChanged: formatDateInput,
                  decoration: InputDecoration(
                    labelText: '날짜 (선택사항)',
                    labelStyle: const TextStyle(fontSize: 13),
                    hintText: '예: 2025.11.01',
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF2196F3),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // 작업 항목 (내부/외부/내외부)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '작업 항목 (선택사항)',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: ['내부', '외부', '내외부'].map((dept) {
                          final isSelected = selectedDepartment == dept;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  selectedDepartment = dept;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    dept,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      color: isSelected ? Colors.white : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 버튼들
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (plateNumberController.text.isNotEmpty &&
                              modelController.text.isNotEmpty) {
                            setState(() {
                              _vehicles.add(
                                Vehicle(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  plateNumber: plateNumberController.text,
                                  model: modelController.text,
                                  department: selectedDepartment,
                                  date: dateController.text.isEmpty ? '-' : dateController.text,
                                  isCompleted: false,
                                ),
                              );
                            });
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('작업이 등록되었습니다'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('차량번호와 차량 모델을 입력해주세요'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: const Color(0xFF2196F3).withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          '추가',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
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
        children: [
          // 주차 선택 드롭다운
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '$_selectedYear ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    // 월 선택 드롭다운
                    GestureDetector(
                      onTapDown: (details) {
                        _showMonthMenu(context, details.globalPosition);
                      },
                      child: Row(
                        children: [
                          Text(
                            '${_selectedMonth}월',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 주차 선택 드롭다운
                    GestureDetector(
                      onTapDown: (details) {
                        _showWeekMenu(context, details.globalPosition);
                      },
                      child: Row(
                        children: [
                          Text(
                            '${_selectedWeek}주차',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: _showAddVehicleDialog,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '+ 차량추가',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 차량 목록
          Expanded(
            child: Builder(
              builder: (context) {
                final filteredVehicles = _getFilteredVehicles();
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: filteredVehicles.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                  itemBuilder: (context, index) {
                    final vehicle = filteredVehicles[index];
                    // 원본 리스트에서의 인덱스 찾기
                    final originalIndex = _vehicles.indexOf(vehicle);
                    return _VehicleCard(
                      vehicle: vehicle,
                      departmentColor: _getDepartmentColor(vehicle.department),
                      siteName: widget.siteName,
                      index: originalIndex,
                      onLongPress: () => _showDeleteConfirmDialog(vehicle, originalIndex),
                    );
                  },
                );
              },
            ),
          ),

          // 전체 현황 버튼
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _navigateToMonthlyStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '전체 현황',
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
  final int index;
  final VoidCallback onLongPress;

  const _VehicleCard({
    required this.vehicle,
    required this.departmentColor,
    required this.siteName,
    required this.index,
    required this.onLongPress,
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
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(
          children: [
            // 날짜
            SizedBox(
              width: 35,
              child: Text(
                vehicle.date,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),

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
                color: departmentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
