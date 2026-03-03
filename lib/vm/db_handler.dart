// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHandler {
//   // DB 생성
//   Future<Database> initializedDB() async {
//     String path = join(await getDatabasesPath(), "address.db");
//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//             CREATE TABLE address(
//               id INTEGER PRIMARY KEY AUTOINCREMENT,
//               name TEXT,
//               phone TEXT,
//               estimate TEXT,
//               lat REAL,
//               lng REAL,
//               image BLOB,
//               actiondate TEXT
//             )
//           ''');
//       },
//     );
//   }

//   // 입력
//   Future<void> insertAddress(Address address) async {
//     final db = await initializedDB();
//     await db.rawInsert(
//       '''
//         INSERT INTO address(name, phone, estimate, lat, lng, image, actiondate)
//         VALUES (?,?,?,?,?,?,datetime('now', 'localtime'))
//       ''',
//       [
//         address.name,
//         address.phone,
//         address.estimate,
//         address.lat,
//         address.lng,
//         address.image,
//       ],
//     );
//   }

//   // 주소 전체 조회
//   Future<List<Address>> queryAddress() async {
//     final db = await initializedDB();
//     final result = await db.rawQuery('SELECT * FROM address');
//     return result.map((data) => Address.fromMap(data)).toList();
//   }

//   // 주소 삭제
//   Future<void> deleteAddress(int id) async {
//     final db = await initializedDB();
//     await db.rawDelete('DELETE FROM address WHERE id = ?', [id]);
//   }

//   // 이미지 제외 수정
//   Future<void> updateAddress(Address address) async {
//     final db = await initializedDB();
//     await db.rawUpdate(
//       '''
//         UPDATE address
//         set name = ?, phone = ?, estimate = ?, lat = ?, lng = ?, actiondate=datetime('now', 'localtime')
//         WHERE id = ?
//       ''',
//       [
//         address.name,
//         address.phone,
//         address.estimate,
//         address.lat,
//         address.lng,
//         address.id,
//       ],
//     );
//   }

//   // 이미지 포함 수정
//   Future<void> updateAddressAll(Address address) async {
//     final db = await initializedDB();
//     await db.rawUpdate(
//       '''
//         UPDATE address
//         set name = ?, phone = ?, estimate = ?, lat = ?, lng = ?, image = ?, actiondate=datetime('now', 'localtime')
//         WHERE id = ?
//       ''',
//       [
//         address.name,
//         address.phone,
//         address.estimate,
//         address.lat,
//         address.lng,
//         address.image,
//         address.id,
//       ],
//     );
//   }
// }
