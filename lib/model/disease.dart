//  Disease Model
/*
  Create: 26/02/2026 16:46, Creator: Chansol, Park
  Desc: Disease Model as result of ML from symptoms chosen by user
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String()
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class Disease {
  // Properties
  int? id;
  final String name;
  final int triage;

  // Constructor
  Disease({this.id, required this.name, required this.triage});

  Disease.fromMap(Map<String, Object?> map)
    : id = map['id'] as int?,
      name = map['name'] as String,
      triage = (map['triage'] as num).toInt();

  Map<String, Object?> toMap({bool includeId = false}) {
    final map = <String, Object?>{'name': name, 'triage': triage};

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  static const List<String> keys = ['id', 'name', 'triage'];
  static const List<String> values = ['primary key integer autoincreament', 'text', 'REAL'];
}
