 


class EnterprenurModel {
  String EnterprenurName;
  String EnterprenurNumber;
  String EnterprenurEmail;
  String EnterprenurPassword;
  String? id;
  String? image;
  String? businesname;
 String? location ;
 String uid;
  

  EnterprenurModel({
    required this.EnterprenurName,
    required this.EnterprenurNumber,
    required this.EnterprenurEmail,
    required this.EnterprenurPassword,
    this.id,
    required  this.image,
    this.businesname,
    this.location,
    required this.uid,
     
  });

  Map<String, dynamic> toJsone(idd) => {
        'EnterprenurName': EnterprenurName,
        'EnterprenurNumber': EnterprenurNumber,
        'EnterprenurEmail': EnterprenurEmail,
        'EnterprenurPassword': EnterprenurPassword,
        'id': idd,
        'profileimage':image,
        'businessname':businesname,
        'location':location,
       'uid':uid,
      };

  factory EnterprenurModel.fromjsone(Map<String, dynamic> Json) {
    return EnterprenurModel(
      EnterprenurName: Json['EnterprenurName'],
      EnterprenurNumber: Json['EnterprenurNumber'],
      EnterprenurEmail: Json['EnterprenurEmail'],
      EnterprenurPassword: Json['EnterprenurPassword'],
      id: Json['idd'],
      image: Json['profileimage'],
       businesname: Json['businessname'],
      location: Json['location'],
      uid: Json['uid']
     
        
    );
  }
}
