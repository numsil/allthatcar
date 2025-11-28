import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'vehicle_detail_screen.dart';

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

  // 임시 차량 데이터
  List<Vehicle> _getMockVehicles() {
    return [
      Vehicle(
        id: '1',
        plateNumber: '10가1234',
        model: '그랜저',
        department: '내부',
        date: '7/1',
        isCompleted: true,
      ),
      Vehicle(
        id: '2',
        plateNumber: '11가1234',
        model: 'GV80',
        department: '내외부',
        date: '7/1',
        isCompleted: false,
      ),
      Vehicle(
        id: '3',
        plateNumber: '10가4321',
        model: '그랜저',
        department: '외부',
        date: '7/1',
        isCompleted: true,
      ),
      Vehicle(
        id: '4',
        plateNumber: '10가6234',
        model: 'GV80',
        department: '내부',
        date: '7/1',
        isCompleted: false,
      ),
      Vehicle(
        id: '5',
        plateNumber: '10나1234',
        model: '그랜저',
        department: '외부',
        date: '7/1',
        isCompleted: false,
      ),
      Vehicle(
        id: '6',
        plateNumber: '10가1111',
        model: 'GV80',
        department: '내부',
        date: '7/1',
        isCompleted: true,
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
            child: ListView.separated(
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
                  departmentColor: _getDepartmentColor(vehicle.department),
                  siteName: widget.siteName,
                  index: index,
                  onLongPress: () => _showDeleteConfirmDialog(vehicle, index),
                );
              },
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
