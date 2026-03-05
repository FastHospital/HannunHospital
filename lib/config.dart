import 'package:intl/intl.dart';
import 'package:mytownmysymptom/db/dao/dao_object.dart';
import 'package:mytownmysymptom/model/hospital.dart';

//  Configuration of the App
/*
  Create: 02/03/2026 18:12, Creator: Chansol, Park
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
    03/03/2026 11:21, 'Point 1, DB Handler added, DB name to Emergency_room', Creator: Chansol, Park
  Version: 1.0
  Desc: Configuration of the App
*/

//  DB
//  For use
//  '${rDBName}${rDBFileExt}';
const String rDBName = 'Emergency_room';  //  Database Name Point 1
const String rDBFileExt = '.db';
const int rVersion = 1;

// Point 1
// DB Handlers
final hospitalHandler = RDAO(dbName: rDBName, tableName: "Hospital", dVersion: rVersion, fromMap: Hospital.fromMap);
final hoscatHandler = RDAO(dbName: rDBName, tableName: "HospitalCategory", dVersion: rVersion, fromMap: Hospital.fromMap);
final categoryHandler = RDAO(dbName: rDBName, tableName: "Category", dVersion: rVersion, fromMap: Hospital.fromMap);
final diseaseHandler = RDAO(dbName: rDBName, tableName: "Disease", dVersion: rVersion, fromMap: Hospital.fromMap);
final symptomsHandler = RDAO(dbName: rDBName, tableName: "Symptoms", dVersion: rVersion, fromMap: Hospital.fromMap);
final sympdisHandler = RDAO(dbName: rDBName, tableName: "SymptomDisease", dVersion: rVersion, fromMap: Hospital.fromMap);
//  Formats
const String dateFormat = 'yyyy-MM-dd'; //  DateTime Format
const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';  //  DateTime Format to second 
final NumberFormat priceFormatter = NumberFormat('#,###.##'); //  Number format ###,###

final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
);

final RegExp rKeys = RegExp(
  r'"([a-zA-Z_])"\s*:',
);