
//  AssemblyDBHandler
/*
  Create: 12/12/2025 17:35, Creator: Chansol, Park
  Update log: 
    DUMMY 9/29/2025 09:53, 'Point X, Description', Creator: Chansol, Park
    14/12/2025 17:28, 'Deleted MultiBatchInsert', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection
  Desc: AssemblyDBHandler
*/


class AssemblyDBHandler {
  final String dbName;
  final int dVersion;

  AssemblyDBHandler({
    required this.dbName,
    required this.dVersion,
  });
}