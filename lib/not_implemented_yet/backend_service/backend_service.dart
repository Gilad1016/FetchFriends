// import 'dart:convert';
//
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../dog_management/dog_item.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class BackendService {
//   //192.168.1.223
//   // static const backendUrl = 'http://192.168.1.223:8080';
//   // static const backendUrl = 'http://gilads-air:8080';
//   static const backendUrl = 'http://127.0.0.1:8080';
//   final sharedPreferences = SharedPreferences.getInstance();
//
//   // IO.Socket socket = IO.io(backendUrl, <String, dynamic>{
//   //   'transports': ['websocket']
//   // });
//
//   BackendService() {
//     // socket.on('connect', (_) {
//     //   print('connect');
//     //   socket.emit('msg', 'test');
//     // });
//     // socket.on('event', (data) => print(data));
//     // socket.on('disconnect', (_) => print('disconnect'));
//     // socket.on('fromServer', (_) => print(_));
//     // socket.on('fromServer', (_) => _subjectCounter.sink.add(_));
//   }
//
//   Future<void> addDog(DogItem dog) async {
//     var url = Uri.parse('$backendUrl/dog/');
//     var body = convert.json.encode(dog.toMap());
//     var token =
//         await sharedPreferences.then((value) => value.getString('token'));
//     if (token == null) {
//       throw Exception("No token found");
//     }
//
//     var response = await http.post(url,
//         body: body,
//         headers: {"Content-Type": "application/json", "Authorization": token});
//     if (response.statusCode == 200) {
//       convert.jsonDecode(response.body);
//       return;
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }
//
//   Future<List<DogItem>?> getDogs() async {
//     var url = Uri.parse('$backendUrl/dog/');
//     var token =
//         await sharedPreferences.then((value) => value.getString('token'));
//     if (token == null) {
//       throw Exception("No token found");
//     }
//
//     var response = await http.get(url,
//         headers: {"Content-Type": "application/json", "Authorization": token});
//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body) as Map<String, dynamic>;
//       final List<dynamic>? rawDogItemsData = responseData['data'] as List<dynamic>?;
//
//       List<DogItem> dogItems = [];
//       if (rawDogItemsData != null) {
//         for (final rawDogItemData in rawDogItemsData) {
//           final dogItemMap = rawDogItemData as Map<String, dynamic>;
//           final dogItem = DogItem.fromMap(dogItemMap);
//           dogItems.add(dogItem);
//         }
//       }
//
//       // print(dogItems);
//       // var jsonResponse = convert.json.decode(response.body);
//       // final dogs = jsonResponse["data"]
//       //     .map<DogItem>((dog) => DogItem.fromMap(dog))
//       //     .toList();
//       return dogItems;
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//     return null;
//   }
// }
