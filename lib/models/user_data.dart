import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/models/park_item.dart';

class UserData {
  String userToken = '';
  List<String> dogIds = [];
  List<DogItem>? dogItems;
  List<ParkItem>? savedParks;
  List<String> savedParksId = [];

  UserData(
      {required this.userToken,
      required this.dogIds,
      required this.savedParksId});

  factory UserData.fromMap(Map<String, dynamic> docDocument) {
    return UserData(
      userToken: docDocument['userToken'] as String,
      dogIds: List<String>.from(docDocument['dogIds'] as List<dynamic>),
      savedParksId:
          List<String>.from(docDocument['savedParksId'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userToken': userToken,
      'dogIds': dogIds,
      'savedParksId': savedParksId,
    };
  }
}
