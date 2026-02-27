//  Symptoms
/*
  Create: 26/02/2026 16:05, Creator: Chansol, Park
  Desc: Symptoms Model for ML and get disease informations
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String()
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class Symptoms {
  // Properties
  int? id;
  final String name;

  // Constructor
  Symptoms({
    this.id, 
    required this.name
  });

  Symptoms.fromMap(Map<String, Object?> map)
    : id = map['id'] as int?,
      name = map['name'] as String;

  Map<String, Object?> toMap({bool includeId = false}) {
    final map = <String, Object?>{
      'name': name, 
    };

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  static const List<String> keys = ['id', 'name'];
  static const List<String> values = ['primary key integer autoincreament', 'text', 'REAL'];
}
