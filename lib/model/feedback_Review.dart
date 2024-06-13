class FeedbackReview {
  String productid;
  String feedback;
  String feedbackcount;
  String useruid;
  String? id;

  FeedbackReview({
    required this.productid,
    required this.feedback,
    required this.feedbackcount,
    required this.useruid,
    this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'ProductId': productid,
        'FeedBack': feedback,
        'id': idd,
        'Feedbackcount':feedbackcount,
        'userid':useruid,
      };

  factory FeedbackReview.fromjsone(Map<String, dynamic> jsone) {
    return FeedbackReview(
      productid: jsone['ProductId'],
      feedback: jsone['FeedBack'],
      feedbackcount: jsone['Feedbackcount'],
      useruid: jsone['userid'],
      id: jsone['id'],
    );
  }
}
