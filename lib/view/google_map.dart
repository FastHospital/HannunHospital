//  Google map for hospital informations
/*
  Create: 02/03/2026 14:03, Creator: Chansol, Park
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Desc: Google map for hospital informations got from crawled data
  Dependency: 
*/

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  const Gmap({super.key});

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  final Completer<GoogleMapController> _gmapController = Completer();
  bool _moving = false; //  현재 위치로 이동 중에 중복으로 버튼을 누르는 것을 방지하기 위한.
  bool _movedOnce = false; //  맵 켤 때 최초 이동을 위한 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map")),
      body: GoogleMap(
        onMapCreated: (c) {
          if (!_gmapController.isCompleted) _gmapController.complete(c);
          if (!_movedOnce) {  //  최초 현재 위치로 이동
            _movedOnce = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _currentLocation();
            });
          }
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 16,
          tilt: 45,
        ),
        rotateGesturesEnabled: false, //  회전 금지
        scrollGesturesEnabled: true, //  스크롤 이동 가능
        zoomGesturesEnabled: true, //  두 손가락으로 줌 가능
        zoomControlsEnabled: true, //  + - 버튼 표시
        compassEnabled: true, //  동서남북 표시
        //  Android에서 장소를 탭했을 때 뜨는 지도 툴바(길찾기/지도 앱 열기 등) 표시 여부 kIsWeb은 웹에서 접속인지 아닌지에 대한 boolean
        mapToolbarEnabled:
            !kIsWeb && defaultTargetPlatform == TargetPlatform.android,
        myLocationButtonEnabled: true, //  내 장소로 이동 버튼
        myLocationEnabled: true, //  내 장소 보기 가능
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _currentLocation,
        child: Icon(Icons.navigation),
      ),
    );
  }

  Future<void> _currentLocation() async {
    if (_moving) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('현재 위치로 이동중이니 잠시만 기다려주세요')));
      return;
    }
    _moving = true;

    try {
      final position = await _getCurrentPosition();
      final controller = await _gmapController.future;

      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          16,
        ),
      );
    } catch (e, dt) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('에러 내용:$e, 상세 사유: $dt')));
    } finally {
      _moving = false;
    }
  }

  LocationSettings _settings() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return AppleSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    }
    return const LocationSettings(accuracy: LocationAccuracy.high);
  }

  Future<Position> _getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location service disabled');

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }

    return await Geolocator.getCurrentPosition(locationSettings: _settings());
  }
}
