//  Hospital
/*
  Create: 26/02/2026 15:42, Creator: Chansol, Park
  Desc: Hospital Local DB Model for Google-map view and categories of diseases result from ML result
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String()
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class Hospital {
  // Properties
  int? id;
  final String name;
  final String phone;
  final double lat;
  final double lng;
  final DateTime openingHour;
  final DateTime closingHour;

  // Constructor
  Hospital({
    this.id, 
    required this.name, 
    required this.phone, 
    required this.lat,
    required this.lng,
    required this.openingHour,
    required this.closingHour,
  });

  Hospital.fromMap(Map<String, Object?> map)
    : id = map['id'] as int?,
      name = map['name'] as String,
      phone = map['phone'] as String,
      lat = (map['lat'] as num).toDouble(),
      lng = (map['lng'] as num).toDouble(),
      closingHour = DateTime.parse(map['closingHour'] as String),
      openingHour = DateTime.parse(map['openingHour'] as String);

  Map<String, Object?> toMap({bool includeId = false}) {
    final map = <String, Object?>{
      'name': name, 
      'phone': phone, 
      'lat': lat,
      'lng': lng,
      'openingHour': openingHour.toIso8601String(),
      'closingHour': closingHour.toIso8601String()
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
    'lat',
    'lng',
    "openingHour",
    "closingHour"
    ];
  static const List<String> values = ['primary key integer autoincreament', 'text', 'REAL'];
}
