import 'package:cloud_firestore/cloud_firestore.dart';

class AddReview {
  String review;
  String uid;
  String? id;
  Timestamp timestamp; // Add timestamp field

  AddReview({
    required this.review,
    required this.uid,
      this.id,
          required this.timestamp,

  });

  Map<String, dynamic> tojsone(idd) => {
        'Review': review,
        'uid': uid,
        'id': idd,
              'timestamp': timestamp,

      };

  factory AddReview.fromjsone(Map<String, dynamic> jsone) {
    return AddReview(
      review: jsone['Review'],
      uid: jsone['uid'],
      id: jsone['id'],
            timestamp: jsone['timestamp'],

    );
  }
}
