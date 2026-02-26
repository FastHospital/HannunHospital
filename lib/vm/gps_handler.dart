import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class GPSState {
  final String latitude;
  final String longitude;

  GPSState({this.latitude = '', this.longitude = ''});

  GPSState copyWith({String? latitude, String? longitude}){
    return GPSState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude
    );
  }
} //  State

class GPSNotifier extends Notifier<GPSState> {

  @override
  GPSState build() => GPSState();

  //  Property for watch
  String latitude = '';
  String longtitude = '';

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition();
      state = state.copyWith(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    }
  }
} //  Notifier

final gpsNotifierProvider = NotifierProvider<GPSNotifier, GPSState>(
  GPSNotifier.new
);
