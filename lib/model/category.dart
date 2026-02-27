//  Category Model
/*
  Create: 26/02/2026 16:28, Creator: Chansol, Park
  Desc: Category Model for figure out which category(described in notion https://www.notion.so/132-313b174d654480bebf62c673c24ee5cb)
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String()
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class Category {
  // Properties
  int? id;
  final String name;

  // Constructor
  Category({
    this.id, 
    required this.name,
  });

  Category.fromMap(Map<String, Object?> map)
    : id = map['id'] as int?,
      name = (map['name'] as String);

  Map<String, Object?> toMap({bool includeId = false}) {
    final map = <String, Object?>{
      'name': name,
    };

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  static const List<String> keys = ['id', "name"];
  static const List<String> values = ['primary key integer autoincreament', 'text', 'REAL'];
}
