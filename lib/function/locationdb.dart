// ignore: camel_case_types
//import 'package:cloud_firestore/cloud_firestore.dart';

class locationData {
  late final String uid;
  late final String lname;
  late final String longitude;
  late final String latitude;

  locationData({
    required this.uid,
    required this.latitude,
    required this.longitude,
    required this.lname,
  });

  factory locationData.froJson(Map<String, dynamic> json) {
    return locationData(
      uid: json['uid'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      lname: json['lname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
      'lname': lname,
    };
  }
}
