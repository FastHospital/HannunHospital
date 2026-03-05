import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytownmysymptom/config.dart';
import 'package:mytownmysymptom/db/dao/dao_object.dart';
import 'package:mytownmysymptom/model/hospital.dart';
import 'package:mytownmysymptom/view/home.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// Read Json file.
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';

// Future<List<Map>> readJsonFile(String filePath) async {
//   var input = await File(filePath).readAsString();
//   var map = jsonDecode(input);
//   return map;
// }
import 'package:flutter/services.dart' show rootBundle;

Future<void> deleteLocalDbOnStart() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, rDBName);

  await deleteDatabase(path);
}

Future<void> initializeLocalDbOnStart() async {
  // // load json file
  // // hospitalHandler.insertKs([]);
  // // final data = readJsonFile('data/final.json');
  String jsonString = await rootBundle.loadString('data/final.json');
  final data =  json.decode(jsonString);

  // List<Map<String, dynamic>> mapList = data
  //   .map((item) => Map<String, dynamic>.from(item))
  //   .toList();
  


  await hospitalHandler.insertKs(data.map((item) => {
    'name': item["name"], 
      'phone': item["phone"],
      
      // GT: 추가된 필드
      'type' : item["type"],
      'city' : item["city"],
      'district' : item["district"],
      'address' : item["address"],
      'generalEmergencyAvailable' : item["generalEmergencyAvailable"],
      'generalEmergencyTotal' : item["generalEmergencyTotal"], 
      // END of GT: 추가된 필드

      'lat': item["lat"],
      'lng': item["lng"],
  }).toList());





}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // remove database
  await deleteLocalDbOnStart();

  // GT: initialize Database
  await initializeLocalDbOnStart();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}