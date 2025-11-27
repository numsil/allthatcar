import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../vehicle/presentation/screens/vehicle_list_screen.dart';

/// 현장 정보 모델
class Site {
  final String id;
  final String name;
  final String description;
  final String logoUrl;

  Site({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // 임시 현장 데이터
  List<Site> _getMockSites() {
    return [
      Site(
        id: '1',
        name: '미래에셋',
        description: '그랑서울 종로',
        logoUrl: 'M', // 로고 이미지가 있으면 교체
      ),
      Site(
        id: '2',
        name: '고려아연',
        description: '그랑서울 종로',
        logoUrl: 'K',
      ),
      Site(
        id: '3',
        name: '인화대병원',
        description: '인천',
        logoUrl: 'I',
      ),
      Site(
        id: '4',
        name: '인스파이어',
        description: '영종도',
        logoUrl: 'I',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sites = _getMockSites();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              '올댓카',
              style: TextStyle(
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
              '현장 선택',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: sites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final site = sites[index];
                return _SiteCard(site: site);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SiteCard extends StatelessWidget {
  final Site site;

  const _SiteCard({required this.site});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 차량 목록 화면으로 이동
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VehicleListScreen(siteName: site.name),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // 로고 아이콘
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  site.logoUrl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 현장 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    site.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    site.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
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
