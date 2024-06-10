 
class Likepostmodel {
  String postid;
  String? likeid;
  String likeuid;

  Likepostmodel({
    required this.postid,
      this.likeid,
    required this.likeuid,
  });

  Map<String, dynamic> toJSne() => {
        'postid': postid,
        'likeid': likeid,
        'likeuid': likeuid,
      };

  factory Likepostmodel.fromjsone(Map<String, dynamic> jsone) {
    return Likepostmodel(
      postid: jsone['postid'],
      likeid: jsone['likeid'],
      likeuid: jsone['likeuid'],
    );
  }
}
