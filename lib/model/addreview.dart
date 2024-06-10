class AddReview {
  String review;
  String uid;
  String? id;

  AddReview({
    required this.review,
    required this.uid,
      this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'Review': review,
        'uid': uid,
        'id': idd,
      };

  factory AddReview.fromjsone(Map<String, dynamic> jsone) {
    return AddReview(
      review: jsone['Review'],
      uid: jsone['uid'],
      id: jsone['id'],
    );
  }
}
