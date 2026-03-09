import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mytownmysymptom/view/preview.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: SeniorMapScreen(hospitals: [],),
    debugShowCheckedModeBanner: false,
  ));
}

class SeniorMapScreen extends StatefulWidget {
  const SeniorMapScreen({super.key, required List<Hospital> hospitals});

  @override
  State<SeniorMapScreen> createState() => _SeniorMapScreenState();
}

class _SeniorMapScreenState extends State<SeniorMapScreen> {
  String _locationMessage = "위치 확인 버튼을 눌러주세요";
  bool _isLoading = false;

  // 1. 현재 위치 권한 요청 및 위치 가져오기
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      setState(() {
        _locationMessage = "현재 위치 확인 완료!";
        _isLoading = false;
      });
      // 확인 후 바로 주변 병원 검색으로 연결 (예시)
      _openMapSearch("주변 응급실");
    } else {
      setState(() {
        _locationMessage = "위치 권한이 거부되었습니다.";
        _isLoading = false;
      });
    }
  }

  // 2. 외부 지도 앱(카카오/네이버/구글)으로 검색 결과 연결
// 2. 외부 지도 앱으로 검색 결과 연결
Future<void> _openMapSearch(String query) async {
  // 인코딩을 통해 한글 검색어가 깨지지 않게 합니다.
  final String encodedQuery = Uri.encodeComponent(query);
  
  // 구글 맵 검색 URL (범용적)
  final Uri googleUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$encodedQuery");
  
  // 카카오맵 검색 URL (설치되어 있다면 더 정확함)
  final Uri kakaoUrl = Uri.parse("kakaomap://search?q=$encodedQuery");

  try {
    // 1. 먼저 카카오맵 시도
    if (await canLaunchUrl(kakaoUrl)) {
      await launchUrl(kakaoUrl);
    } 
    // 2. 카카오맵 없으면 구글 맵/웹브라우저 시도
    else if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } 
    else {
      throw '지도를 열 수 없습니다.';
    }
  } catch (e) {
    // 에러 발생 시 사용자에게 알림 (어르신용 큰 글씨 스낵바)
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "지도를 실행할 수 없습니다: $e",
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD32F2F); // 어르신들이 인지하기 쉬운 붉은 계열 (긴급/중요)
    const Color hospitalColor = Color(0xFF2E7D32); // 안정감을 주는 초록 계열

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('병원 길찾기 도우미', 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 현재 상태 표시창
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                children: [
                  const Icon(Icons.location_on, size: 50, color: primaryColor),
                  const SizedBox(height: 10),
                  Text(_locationMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  if (_isLoading) const CircularProgressIndicator(),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 큰 버튼 1: 길찾기 (병원)
            _bigButton(
              label: "가까운 병원 찾기",
              icon: Icons.local_hospital,
              color: hospitalColor,
              onPressed: () => _openMapSearch("가까운 병원"),
            ),
            const SizedBox(height: 20),

            // 큰 버튼 2: 길찾기 (약국)
            _bigButton(
              label: "가까운 약국 찾기",
              icon: Icons.local_pharmacy,
              color: const Color(0xFF1976D2),
              onPressed: () => _openMapSearch("가까운 약국"),
            ),
            const SizedBox(height: 20),

            // 큰 버튼 3: 현재 위치 갱신
            _bigButton(
              label: "내 위치 확인하기",
              icon: Icons.my_location,
              color: Colors.orange.shade800,
              onPressed: _getCurrentLocation,
            ),
             const Spacer(),
            // const Text("버튼을 누르면 지도로 연결됩니다.", 
            //   style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // 노안을 고려한 크고 선명한 버튼 위젯
  Widget _bigButton({
    required String label, 
    required IconData icon, 
    required Color color, 
    required VoidCallback onPressed
  }) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 35, color: Colors.white),
        label: Text(label, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
        ),
      ),
    );
  }
}