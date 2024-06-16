import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackReview {
  String productid;
  String feedback;
  String feedbackcount;
  String useruid;
  String? id;
 final Timestamp timestamp; // Add timestamp field
  FeedbackReview({
    required this.productid,
    required this.feedback,
    required this.feedbackcount,
    required this.useruid,
    this.id,
     required this.timestamp,
  });

  Map<String, dynamic> tojsone(idd) => {
        'ProductId': productid,
        'FeedBack': feedback,
        'id': idd,
        'Feedbackcount':feedbackcount,
        'userid':useruid,
        'timestamp':timestamp
        
      };

  factory FeedbackReview.fromjsone(Map<String, dynamic> jsone) {
    return FeedbackReview(
      productid: jsone['ProductId'],
      feedback: jsone['FeedBack'],
      feedbackcount: jsone['Feedbackcount'],
      useruid: jsone['userid'],
      id: jsone['id'],
       timestamp: jsone['timestamp'],
    );
  }
}
