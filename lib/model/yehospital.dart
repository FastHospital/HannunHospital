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

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      id: map['id'] as int?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      type: map['type'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      address: map['address'] as String,
      generalEmergencyAvailable: map['generalEmergencyAvailable'] != null
          ? int.parse(map['generalEmergencyAvailable'].toString())
          : 0,
      generalEmergencyTotal: map['generalEmergencyTotal'] != null
          ? int.parse(map['generalEmergencyTotal'].toString())
          : 0,
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
      openingHour: map['openingHour'] != null
          ? DateTime.parse(map['openingHour'] as String)
          : null,
      closingHour: map['closingHour'] != null
          ? DateTime.parse(map['closingHour'] as String)
          : null,
    );
  }

  Map<String, Object?> toMap({bool includeId = false}) {
    final Map<String, Object?> map = {
      'name': name,
      'phone': phone,
      'type': type,
      'city': city,
      'district': district,
      'address': address,
      'generalEmergencyAvailable': generalEmergencyAvailable,
      'generalEmergencyTotal': generalEmergencyTotal,
      'lat': lat,
      'lng': lng,
      'openingHour': openingHour?.toIso8601String(),
      'closingHour': closingHour?.toIso8601String(),
    };

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  static const List<String> keys = [
    'id',
    'name',
    'phone',
    'type',
    'city',
    'district',
    'address',
    'generalEmergencyAvailable',
    'generalEmergencyTotal',
    'lat',
    'lng',
    'openingHour',
    'closingHour',
  ];

  static const List<String> values = [
    'primary key integer autoincrement',
    'text',
    'text',
    'text',
    'text',
    'text',
    'text',
    'integer',
    'integer',
    'REAL',
    'REAL',
    'datetime',
    'datetime',
  ];
}