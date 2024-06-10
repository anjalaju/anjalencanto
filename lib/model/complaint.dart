class ComplaintModel {
  String complaint;
  String uid;
  String? id;

  ComplaintModel({
    required this.complaint,
    required this.uid,
      this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'Complaint': complaint,
        'uid': uid,
        'id': idd,
      };

  factory ComplaintModel.fromjsone(Map<String, dynamic> jsone) {
    return ComplaintModel(
      complaint: jsone['Complaint'],
      uid: jsone['uid'],
      id: jsone['id'],
    );
  }
}
