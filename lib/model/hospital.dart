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

  // GT: 추가된 필드
  final String type;
  final String city;        // 서울특별시...
  final String district;    // 구 정보 (강남구..)
  final String address;     // 주소
  final int? generalEmergencyAvailable;
  final int? generalEmergencyTotal;
  // final int? childEmergencyAvailable;
  // final int? childEmergencyTotal;
  // final bool? deliveryRoomAvailable;
  // final int? deliveryRoomTotal;
  // END of GT: 추가된 필드

  final double lat;       
  final double lng;
  final DateTime? openingHour;
  final DateTime? closingHour;

  // Constructor
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
    // this.childEmergencyAvailable,
    // this.childEmergencyTotal,
    // this.deliveryRoomAvailable,
    // this.deliveryRoomTotal,

    required this.lat,
    required this.lng,
    this.openingHour,
    this.closingHour,
  });

  Hospital.fromMap(Map<String, dynamic> map)
  : id = map['id'] as int?,
      name = map['name'] as String,
      phone = map['phone'] as String,


      // GT: 추가된 필드
      type = map['type'] as String,
      city = map['city'] as String,
      district = map['district'] as String,
      address = map['address'] as String,

      generalEmergencyAvailable = map['generalEmergencyAvailable'] != null ?  int.parse(map['generalEmergencyAvailable'].toString()) : 0,
      generalEmergencyTotal = map['generalEmergencyTotal']!=null ? int.parse(map['generalEmergencyTotal'].toString()) : 0,
      // childEmergencyAvailable = map['childEmergencyAvailable'] as int,
      // childEmergencyTotal = map['childEmergencyTotal'] as int,
      // deliveryRoomAvailable =  map['childEmergencyTotal'] as bool,
      // deliveryRoomTotal = map['deliveryRoomTotal'] as int,
      // END of GT: 추가된 필드

      lat = (map['lat'] as num).toDouble(),
      lng = (map['lng'] as num).toDouble(),
      closingHour = map['closingHour'] != null ? DateTime.parse(map['closingHour'] as String) : DateTime.now(),
      openingHour = map['openingHour'] != null ? DateTime.parse(map['openingHour'] as String) : DateTime.now();
      
  Map<String, Object?> toMap({bool includeId = false}) {

    final map = {
      'name': name, 
      'phone': phone,
      
      // GT: 추가된 필드
      'type' : type,
      'city' : city,
      'district' : district,
      'address' : address,
      'generalEmergencyAvailable' : generalEmergencyAvailable,
      'generalEmergencyTotal' : generalEmergencyTotal, 
      // END of GT: 추가된 필드

      'lat': lat,
      'lng': lng,
      //'openingHour': openingHour.toIso8601String(),
      //'closingHour': closingHour.toIso8601String()
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
    
    // GT: 추가된 필드
    'type',
    'city',
    'district',
    'address'
    'generalEmergencyAvailable',
    'generalEmergencyTotal',
    // END of GT: 추가된 필드

    'lat',
    'lng',
    "openingHour",
    "closingHour"
    ];
  static const List<String> values = [
    'primary key integer autoincreament', 
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
    'datetime'
  ];
}
