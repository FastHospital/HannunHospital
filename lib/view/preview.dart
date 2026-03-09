import 'package:flutter/material.dart';

// 네 Hospital 모델 import
// 경로는 프로젝트 구조에 맞게 수정
// import 'package:your_project/models/hospital.dart';

void main() {
  runApp(const MyApp());
}

class Hospital {
  int? id;
  final String name;
  final String phone;
  final String type;
  final String city;
  final String district;
  final String address;
  final int? generalEmergencyAvailable;
  final int? generalEmergencyTotal;
  final double lat;
  final double lng;
  final DateTime? openingHour;
  final DateTime? closingHour;

  Hospital({
    this.id,
    required this.name,
    required this.phone,
    required this.type,
    required this.city,
    required this.district,
    required this.address,
    this.generalEmergencyAvailable,
    this.generalEmergencyTotal,
    required this.lat,
    required this.lng,
    this.openingHour,
    this.closingHour,
  });
}

final List<Hospital> demoHospitals = [
  Hospital(
    id: 1,
    name: '시온병원',
    phone: '02-1234-5678',
    type: '정형외과',
    city: '서울특별시',
    district: '강남구',
    address: '서울특별시 강남구 테헤란로 101',
    generalEmergencyAvailable: 8,
    generalEmergencyTotal: 8,
    lat: 37.498,
    lng: 127.027,
    openingHour: DateTime(2026, 1, 1, 10, 0),
    closingHour: DateTime(2026, 1, 1, 20, 0),
  ),
  Hospital(
    id: 2,
    name: '강남튼튼병원',
    phone: '02-2222-3333',
    type: '재활의학과',
    city: '서울특별시',
    district: '강남구',
    address: '서울특별시 강남구 봉은사로 22',
    generalEmergencyAvailable: 5,
    generalEmergencyTotal: 8,
    lat: 37.501,
    lng: 127.031,
    openingHour: DateTime(2026, 1, 1, 9, 0),
    closingHour: DateTime(2026, 1, 1, 18, 0),
  ),
  Hospital(
    id: 3,
    name: '서울신경병원',
    phone: '02-5555-7777',
    type: '신경과',
    city: '서울특별시',
    district: '서초구',
    address: '서울특별시 서초구 서초대로 88',
    generalEmergencyAvailable: 3,
    generalEmergencyTotal: 6,
    lat: 37.491,
    lng: 127.012,
    openingHour: DateTime(2026, 1, 1, 9, 30),
    closingHour: DateTime(2026, 1, 1, 19, 30),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospital UI',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff7f7f7),
      ),
      home: HospitalSearchScreen(hospitals: demoHospitals),
    );
  }
}

class HospitalSearchScreen extends StatefulWidget {
  final List<Hospital> hospitals;

  const HospitalSearchScreen({
    super.key,
    required this.hospitals,
  });

  @override
  State<HospitalSearchScreen> createState() => _HospitalSearchScreenState();
}

class _HospitalSearchScreenState extends State<HospitalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Hospital> filteredHospitals;

  @override
  void initState() {
    super.initState();
    filteredHospitals = widget.hospitals;
  }

  void _filterHospitals(String keyword) {
    setState(() {
      if (keyword.trim().isEmpty) {
        filteredHospitals = widget.hospitals;
      } else {
        filteredHospitals = widget.hospitals.where((hospital) {
          return hospital.name.contains(keyword) ||
              hospital.type.contains(keyword) ||
              hospital.district.contains(keyword) ||
              hospital.address.contains(keyword);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _TopTitle(title: '병원 선택'),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: _filterHospitals,
                    decoration: InputDecoration(
                      hintText: '병원 이름',
                      filled: true,
                      fillColor: const Color(0xffeeeeee),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 현재 위치 기반 정렬/검색 연결
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4db3ff),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('현재 위치로 찾기'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredHospitals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final hospital = filteredHospitals[index];
                  return _HospitalListTile(
                    hospital: hospital,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HospitalDetailScreen(hospital: hospital),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalDetailScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailScreen({
    super.key,
    required this.hospital,
  });

  String formatTime(DateTime? time) {
    if (time == null) return '-';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final openTime = formatTime(hospital.openingHour);
    final closeTime = formatTime(hospital.closingHour);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopTitle(
              title: hospital.name,
              onBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 210,
                decoration: BoxDecoration(
                  color: const Color(0xffd8ecff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_hospital,
                  size: 80,
                  color: Color(0xff58bdfc),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 1
                        ? const Color(0xff58bdfc)
                        : const Color(0xffd9d9d9),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _InfoRow(label: '병원명', value: hospital.name),
                  const SizedBox(height: 14),
                  _InfoRow(label: '진료과', value: hospital.type),
                  const SizedBox(height: 14),
                  _InfoRow(
                    label: '영업시간',
                    value: '$openTime ~ $closeTime',
                  ),
                  const SizedBox(height: 14),
                  _InfoRow(label: '주소', value: hospital.address),
                  const SizedBox(height: 14),
                  _InfoRow(label: '전화', value: hospital.phone),
                  const SizedBox(height: 14),
                  _InfoRow(
                    label: '응급실',
                    value:
                        '${hospital.generalEmergencyAvailable ?? 0} / ${hospital.generalEmergencyTotal ?? 0}',
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 전화 연결 기능
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4db3ff),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('전화하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHospitalScreen extends StatelessWidget {
  final Hospital hospital;

  const MyHospitalScreen({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> departments = [
      hospital.type,
      '재활의학과',
      '마취통증의학과',
      '신경과',
      '정형외과',
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopTitle(
              title: '내 병원은..',
              onBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
            ...departments.map(
              (item) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xffededed),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Color(0xff58bdfc),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                '${hospital.name}은(는)\n신뢰도가 높은 병원이에요',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black38,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4db3ff),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('전화하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalMapScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalMapScreen({
    super.key,
    required this.hospital,
  });

  String formatTime(DateTime? time) {
    if (time == null) return '-';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopTitle(
              title: '병원찾기',
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: const Color(0xffdfe6ec),
                    child: Center(
                      child: Text(
                        '지도 영역\n(${hospital.lat}, ${hospital.lng})',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 130,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 38,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            hospital.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black12,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: const Color(0xffd9f2ff),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_hospital,
                                  color: Color(0xff58bdfc),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hospital.type,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      hospital.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '영업시간   ${formatTime(hospital.openingHour)} ~ ${formatTime(hospital.closingHour)}',
                                    ),
                                    const SizedBox(height: 4),
                                    Text('주소   ${hospital.address}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff4db3ff),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                elevation: 0,
                              ),
                              child: const Text('전화하기'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        HospitalDetailScreen(hospital: hospital),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('자세히 보기'),
                            ),
                          ),
                        ],
                      ),
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

class _TopTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const _TopTitle({
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _HospitalListTile extends StatelessWidget {
  final Hospital hospital;
  final VoidCallback? onTap;

  const _HospitalListTile({
    required this.hospital,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final emergencyText =
        '${hospital.generalEmergencyAvailable ?? 0}/${hospital.generalEmergencyTotal ?? 0}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xffd9f2ff),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.local_hospital,
              color: Color(0xff58bdfc),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xffececec)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital.type,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hospital.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${hospital.district} · ${hospital.address}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '일반응급: $emergencyText',
                    style: const TextStyle(
                      color: Color(0xff58bdfc),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xff58bdfc),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}