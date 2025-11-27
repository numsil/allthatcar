import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'photo_gallery_screen.dart';
import 'work_registration_screen.dart';

class VehicleDetailScreen extends StatefulWidget {
  final String siteName;
  final String plateNumber;

  const VehicleDetailScreen({
    super.key,
    required this.siteName,
    required this.plateNumber,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _photos = [];
  final Set<int> _selectedIndices = {};
  bool _isSelectMode = false;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85,
      );

      if (photo != null && mounted) {
        setState(() {
          _photos.add(photo);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('사진 촬영 완료 (${_photos.length}장)'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
            action: SnackBarAction(
              label: '보기',
              textColor: Colors.white,
              onPressed: _viewGallery,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('카메라 오류: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _viewGallery() async {
    if (_photos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('촬영된 사진이 없습니다'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    final result = await Navigator.of(context).push<List<XFile>>(
      MaterialPageRoute(
        builder: (context) => PhotoGalleryScreen(
          siteName: widget.siteName,
          plateNumber: widget.plateNumber,
          photos: _photos,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _photos.clear();
        _photos.addAll(result);
      });
    }
  }

  void _toggleSelectMode() {
    setState(() {
      _isSelectMode = !_isSelectMode;
      if (!_isSelectMode) {
        _selectedIndices.clear();
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  Future<void> _registerPhotos() async {
    if (_selectedIndices.isEmpty) return;

    // 선택된 사진들만 추출
    final selectedPhotos = _selectedIndices
        .map((index) => _photos[index])
        .toList();

    // 작업 등록 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkRegistrationScreen(
          siteName: widget.siteName,
          plateNumber: widget.plateNumber,
          selectedPhotos: selectedPhotos,
        ),
      ),
    );
  }

  void _checkWorkStatus() {
    // TODO: 작업 현황 확인 페이지로 이동
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('작업 현황 페이지'),
        duration: Duration(seconds: 1),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 차량 번호
            Row(
              children: [
                Text(
                  widget.plateNumber,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 사진 미리보기 그리드
            if (_photos.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    // 선택하기 버튼
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: _toggleSelectMode,
                            icon: Icon(
                              _isSelectMode ? Icons.close : Icons.check_circle_outline,
                              size: 18,
                            ),
                            label: Text(
                              _isSelectMode ? '취소' : '선택하기',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 사진 그리드
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _photos.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedIndices.contains(index);

                          return GestureDetector(
                            onTap: () {
                              if (_isSelectMode) {
                                _toggleSelection(index);
                              } else {
                                _viewGallery();
                              }
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_photos[index].path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (_isSelectMode)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF2196F3)
                                            : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF2196F3)
                                              : Colors.grey[400]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              const Spacer(),

            // 등록하기 버튼 (선택 모드이고 선택된 사진이 있을 때만 표시)
            if (_isSelectMode && _selectedIndices.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _registerPhotos,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.upload, size: 20),
                    label: Text(
                      '등록하기 (${_selectedIndices.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

            // 사진 촬영 버튼
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _takePhoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.camera_alt, size: 20),
                label: const Text(
                  '사진 촬영',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 작업 현황 버튼
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _checkWorkStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE3F2FD),
                  foregroundColor: const Color(0xFF2196F3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '작업 현황',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
