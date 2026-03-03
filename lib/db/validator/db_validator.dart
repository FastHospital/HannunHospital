import 'package:sqflite/sqflite.dart';

//  db_validator
/*
  Create: 15/12/2025 12:28, Creator: Chansol, Park
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
    16/12/2025 12:16, 'Point 1, SQLite Type presets', Creator: Chansol, Park
  Version: 1.0
  Dependency: 
  Desc: db_validator
*/

//  Point 1
enum SQLiteType { integer, real, text, blob }

extension SQLiteTypeX on SQLiteType {
  String get sql {
    switch (this) {
      case SQLiteType.integer:
        return 'INTEGER';
      case SQLiteType.real:
        return 'REAL';
      case SQLiteType.text:
        return 'TEXT';
      case SQLiteType.blob:
        return 'BLOB';
    }
  }
}

extension SQLiteTypeParser on String {
  SQLiteType toSQLiteType() {
    final upper = toUpperCase();

    if (upper.contains('INT')) return SQLiteType.integer;
    if (upper.contains('CHAR') || upper.contains('TEXT')) {
      return SQLiteType.text;
    }
    if (upper.contains('REAL') || upper.contains('FLOA') || upper.contains('DOUB')) {
      return SQLiteType.real;
    }
    if (upper.contains('BLOB')) return SQLiteType.blob;

    return SQLiteType.text;
  }
}

//  Validator Model
class AttributeMeta {
  //  Property
  final String name;
  final SQLiteType type;
  final bool isPrimaryKey;
  final bool isNotNull;
  final bool hasDefaultValue;

  //  Constructor
  AttributeMeta({
    required this.name,
    required this.type,
    required this.isPrimaryKey,
    required this.isNotNull,
    required this.hasDefaultValue,
  });

  //  Factrory
  factory AttributeMeta.fromPragma(Map<String, Object?> att) {
    return AttributeMeta(
      name: att['name'] as String,
      type: (att['type'] as String).toSQLiteType(),
      isPrimaryKey: (att['pk'] as int) > 0,
      isNotNull: (att['notnull'] as int) > 0 || (att['pk'] as int) > 0,
      hasDefaultValue: att['dflt_value'] != null,
    );
  }
}

Future<void> columnValidator({
  required Database db,
  required String tableName,
  required List<AttributeMeta> sampleAttributes,
}) async {
  final List<Map<String, Object?>> rawAttributes = await db.rawQuery(
    'PRAGMA table_info($tableName)',
  );
  final List<AttributeMeta> actualAttributes = rawAttributes
      .map(AttributeMeta.fromPragma)
      .toList();
  if (actualAttributes.length != sampleAttributes.length) {
    print('Both table\'s LENGTH is DIFFERENT! $tableName');
  }
  for (int index = 0; index < actualAttributes.length; index++) {
    final AttributeMeta actual = actualAttributes[index];
    final AttributeMeta sample = sampleAttributes[index];
    final checker = {
      'KEYNAME': actual.name == sample.name,
      'TYPE': actual.type == sample.type,
      'PRIMARY KEY': actual.isPrimaryKey == sample.isPrimaryKey,
      'NOTNULL': actual.isNotNull == sample.isNotNull,
      'DEFAULT VALUE': actual.hasDefaultValue == sample.hasDefaultValue,
    };
    for (final entry in checker.entries) {
      if (!entry.value) {
        print(
          'Both table\'s ${entry.key} is DIFFERENT at '
          '$index${ordinalSuffix(index)} attribute ${sample.name}',
        );
        break;
      }
    }
  }
}

String ordinalSuffix(int i) {
  final int input = i + 1;
  switch (input % 10) {
    case 1:
      return input % 100 == 11 ? 'th' : 'st';
    case 2:
      return input % 100 == 12 ? 'th' : 'nd';
    case 3:
      return input % 100 == 13 ? 'th' : 'rd';
    default:
      return 'th';
  }
}
