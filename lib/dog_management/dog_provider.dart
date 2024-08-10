import 'dart:async';
import '../common/providers/app_state/app_state_provider.dart';
import 'package:pocketbase/pocketbase.dart';

class DogProvider {
  late final PocketBase pb;
  late final AppStateProvider appStateProvider;

  DogProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    appStateProvider = AppStateProvider();
    pb = PocketBase('http://127.0.0.1:8090/');
  }

  Future<String> addDog(String name, String ownerUID) async {
    final body = <String, dynamic>{
      "name": name,
      "ownerUID": ownerUID,
    };
    RecordModel dogData;
    try {
      dogData = await pb.collection('dogs').create(body: body);
    } catch (e) {
      print(e);
      return 'Error adding dog';
    }
    if (dogData.data == "") {
      return 'Error adding dog';
    }
    return 'success';
  }

  Future<String> deleteDog(String dogID) async {
    try {
      await pb.collection('dogs').delete(dogID);
    } catch (e) {
      print(e);
      return 'Error deleting dog';
    }
    return 'success';
  }

  Future<String> updateDog(String dogID, String name) async {
    final body = <String, dynamic>{
      "name": name,
    };
    try {
      await pb.collection('dogs').update(dogID, body: body);
    } catch (e) {
      print(e);
      return 'Error updating dog';
    }
    return 'success';
  }
}
