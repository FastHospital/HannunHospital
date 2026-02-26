import 'package:custom_restitutor/db/validator/db_validator.dart';

//  Model SQL assembler
/*
  Create: 15/12/2025 15:53, Creator: Chansol, Park
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: 
  Desc: Model SQL assembler
*/

class ModelMeta {
  //  Property
  final String dbName;
  final String tableName;
  final int dVersion;
  final List<AttributeMeta> model;
  
  //  Constructor
  ModelMeta({
    required this.dbName,
    required this.tableName,
    required this.dVersion,
    required this.model
  });
}

enum SQLType { c, r, u, d }

sqlAssembler(ModelMeta input) {
  // Property
  final String tn = input.tableName;
  final model = input.model;

  final List<String> resultClause = [];

  for (int i = 0; i < model.length; i++) {
    final attr = model[i];

    String attClause = attr.name.toUpperCase();

    attClause += ' ${attr.type.sql}';

    if (attr.isPrimaryKey) {
      attClause += ' PRIMARY KEY';

      if (attr.type == SQLiteType.integer) {
        attClause += ' AUTOINCREMENT';
      }
    }

    if (attr.isNotNull && !attr.isPrimaryKey) {
      attClause += ' NOT NULL';
    }

    resultClause.add(attClause);
  }

  final String sql = '''
CREATE TABLE $tn (
  ${resultClause.join(',\n  ')}
);
''';

  return sql;
}