// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class VMNotifier extends AsyncNotifier<List<Address>> {
//   @override
//   Future<List<Address>> build() async => _dbHandler.queryAddress();

//   final _dbHandler =
//       DatabaseHandler();

//   Future<void> loadAddress() async {
//     state = AsyncLoading(); //
//     state = await AsyncValue.guard(() async => _dbHandler.queryAddress(),);
//   }

//   Future<void> insertAddress(Address address) async {
//     await _dbHandler.insertAddress(address);
//     await loadAddress();
//   }

//   Future<void> updateAddress(Address address) async {
//     await _dbHandler.updateAddress(address);
//     await loadAddress();
//   }

//   Future<void> updateAddressAll(Address address) async {
//     await _dbHandler.updateAddressAll(address);
//     await loadAddress();
//   }

//   Future<void> deleteAddress(int id) async {
//     await _dbHandler.deleteAddress(id);
//     await loadAddress();
//   }
// }

// //  Provider
// final vmNotifierProvider = AsyncNotifierProvider<VMNotifier, List<Address>>(
//   VMNotifier.new,
// );
