//  SymptomDisease Model
/*
  Create: 26/02/2026 16:47, Creator: Chansol, Park
  Desc: SymptomDisease Associative Model
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String()
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class SymptomDisease {
  // Properties
  int? id;
  int sid;
  int did;

  // Constructor
  SymptomDisease({this.id, required this.sid, required this.did});

  SymptomDisease.fromMap(Map<String, Object?> map)
    : id = map['id'] as int?,
      sid = (map['sid'] as num).toInt(),
      did = (map['did'] as num).toInt();

  Map<String, Object?> toMap({bool includeId = false}) {
    final map = <String, Object?>{'value1': sid, 'value2': did};

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  static const List<String> keys = ['id', 'sid', 'did'];
  static const List<String> values = ['primary key integer autoincreament', 'text', 'REAL'];
}
