import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mytownmysymptom/config.dart';
import 'package:mytownmysymptom/view/hello.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> deleteLocalDbOnStart() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, rDBName);
  await deleteDatabase(path);
}

Future<void> initializeLocalDbOnStart() async {
  // JSON 파일 로드
  final jsonString = await rootBundle.loadString('data/final.json');
  final data = json.decode(jsonString);

  // hospitalHandler는 config.dart 등에서 제공된다고 가정
  await hospitalHandler.insertKs(
    data
        .map((item) => {
              'name': item["name"],
              'phone': item["phone"],

              // 추가된 필드
              'type': item["type"],
              'city': item["city"],
              'district': item["district"],
              'address': item["address"],
              'generalEmergencyAvailable': item["generalEmergencyAvailable"],
              'generalEmergencyTotal': item["generalEmergencyTotal"],

              'lat': item["lat"],
              'lng': item["lng"],
            })
        .toList(),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DB 초기화 (필요 없으면 이 두 줄은 나중에 지워도 됨)
  await deleteLocalDbOnStart();
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const Hello(), // 또는 home: Home(),
    );
  }
}