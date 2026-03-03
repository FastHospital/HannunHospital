import 'package:flutter/material.dart';
import 'package:mytownmysymptom/config.dart';
import 'package:mytownmysymptom/view/home.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> deleteLocalDbOnStart() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, rDBName);

  await deleteDatabase(path);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await deleteLocalDbOnStart();

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