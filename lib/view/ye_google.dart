import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/hospital.dart';

class SeniorMapScreen extends StatefulWidget {
  final List<Hospital> hospitals;

  const SeniorMapScreen({
    super.key,
    required this.hospitals,
  });

  @override
  State<SeniorMapScreen> createState() => _SeniorMapScreenState();
}

class _SeniorMapScreenState extends State<SeniorMapScreen> {
  GoogleMapController? _mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    final Set<Marker> loadedMarkers = widget.hospitals
        .where((h) => h.lat != 0 && h.lng != 0)
        .map(
          (hospital) => Marker(
            markerId: MarkerId(hospital.id?.toString() ?? hospital.name),
            position: LatLng(hospital.lat, hospital.lng),
            infoWindow: InfoWindow(
              title: hospital.name,
              snippet: hospital.address,
              onTap: () {
                _showHospitalBottomSheet(hospital);
              },
            ),
            onTap: () {
              _showHospitalBottomSheet(hospital);
            },
          ),
        )
        .toSet();

    setState(() {
      markers = loadedMarkers;
    });
  }

  void _showHospitalBottomSheet(Hospital hospital) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              Text(
                hospital.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('진료과: ${hospital.type}'),
              Text('주소: ${hospital.address}'),
              Text('전화: ${hospital.phone}'),
              Text(
                '일반응급: ${hospital.generalEmergencyAvailable ?? 0}/${hospital.generalEmergencyTotal ?? 0}',
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // 상세화면 이동 연결 가능
                  },
                  child: const Text('자세히 보기'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng initialPosition = widget.hospitals.isNotEmpty
        ? LatLng(widget.hospitals.first.lat, widget.hospitals.first.lng)
        : const LatLng(37.5665, 126.9780);

    return Scaffold(
      appBar: AppBar(
        title: const Text('병원 지도'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 14,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: markers,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}