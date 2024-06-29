import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  int? Age;
  String Email;
  String id;
  String Image;
  String Mobile_No;
  String Place;
  String User_Name;
  Timestamp timestamp;

  Usermodel({
    required this.Age,
    required this.Email,
    required this.Image,
    required this.Mobile_No,
    required this.Place,
    required this.User_Name,
    required this.id,
    required this.timestamp,
  });

  factory Usermodel.fromJosne(Map<String, dynamic> jsone) {
    return Usermodel(
      Age: jsone['Age'] ?? 0,
      Email: jsone['Email'] ?? '',
      Image: jsone['Image'] ?? '',
      Mobile_No: jsone['Mobile_No'] ?? '',
      Place: jsone['Place'] ?? '',
      User_Name: jsone['User_Name'] ?? '',
      id: jsone['id'] ?? '',
      timestamp: jsone['timestamp'] ?? '',
    );
  }
}
