// class ComplaintModel {
//   String complaint;
//   String uid;
//   String? id;

//   ComplaintModel({
//     required this.complaint,
//     required this.uid,
//       this.id,
//   });

//   Map<String, dynamic> tojsone(idd) => {
//         'Complaint': complaint,
//         'uid': uid,
//         'id': idd,
//       };

//   factory ComplaintModel.fromjsone(Map<String, dynamic> jsone) {
//     return ComplaintModel(
//       complaint: jsone['Complaint'],
//       uid: jsone['uid'],
//       id: jsone['id'],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  String complaint;
  String uid;
  String? id;
  Timestamp timestamp; // Add timestamp field

  ComplaintModel({
    required this.complaint,
    required this.uid,
    this.id,
    required this.timestamp,
  });

  Map<String, dynamic> tojsone(String id) {
    return {
      'complaint': complaint,
      'uid': uid,
      'id': id,
      'timestamp': timestamp,
    };
  }

  factory ComplaintModel.fromjsone(Map<String, dynamic> json) {
    return ComplaintModel(
      complaint: json['complaint'],
      uid: json['uid'],
      id: json['id'],
      timestamp: json['timestamp'],
    );
  }
}
