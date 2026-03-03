//  HospitalCategory Model
/*
  Create: 26/02/2026 16:39, Creator: Chansol, Park
  Desc: Associative Entity fot Hospital and Category(Multiple category can be designated to Multiple Hospitals(N:M))
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String()
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class HospitalCategory {
  // Properties
  int? id;
  int hid;
  int cid;

  // Constructor
  HospitalCategory({this.id, required this.hid, required this.cid});

  HospitalCategory.fromMap(Map<String, Object?> map)
    : id = map['id'] as int?,
      hid = map['hid'] as int,
      cid = map['cid'] as int;

  Map<String, Object?> toMap({bool includeId = false}) {
    final map = <String, Object?>{'value1': hid, 'value2': cid};

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  static const List<String> keys = ['id', 'hid', 'cid'];
  static const List<String> values = ['primary key integer autoincreament', 'text', 'REAL'];
}
