 


// class EnterprenurModel {
//   String EnterprenurName;
//   String EnterprenurNumber;
//   String EnterprenurEmail;
//   String EnterprenurPassword;
//   String? id;
//   String? image;
//   String? businesname;
//  String? location ;
//  String uid;
//  String usertype;
  

//   EnterprenurModel({
//     required this.EnterprenurName,
//     required this.EnterprenurNumber,
//     required this.EnterprenurEmail,
//     required this.EnterprenurPassword,
//     this.id,
//     required  this.image,
//     this.businesname,
//     this.location,
//     required this.uid,
//     required this.usertype,
     
//   });

//   Map<String, dynamic> toJsone(idd) => {
//         'EnterprenurName': EnterprenurName,
//         'EnterprenurNumber': EnterprenurNumber,
//         'EnterprenurEmail': EnterprenurEmail,
//         'EnterprenurPassword': EnterprenurPassword,
//         'id': idd,
//         'profileimage':image,
//         'businessname':businesname,
//         'location':location,
//        'uid':uid,
//        'usertpe':usertype
//       };

//   factory EnterprenurModel.fromjsone(Map<String, dynamic> Json) {
//     return EnterprenurModel(
//       EnterprenurName: Json['EnterprenurName'],
//       EnterprenurNumber: Json['EnterprenurNumber'],
//       EnterprenurEmail: Json['EnterprenurEmail'],
//       EnterprenurPassword: Json['EnterprenurPassword'],
//       id: Json['idd'],
//       image: Json['profileimage'],
//        businesname: Json['businessname'],
//       location: Json['location'],
//       uid: Json['uid'],
//      usertype: Json['usertype'],
        
//     );
//   }
// }
class EnterprenurModel {
  String entrepreneurName;
  String entrepreneurNumber;
  String entrepreneurEmail;
  String entrepreneurPassword;
  String? id;
  String? image;
  String? businessName;
  String? location;
  String uid;
  String userType;
DateTime timestamp;
  EnterprenurModel({
    required this.entrepreneurName,
    required this.entrepreneurNumber,
    required this.entrepreneurEmail,
    required this.entrepreneurPassword,
    this.id,
    this.image,
    this.businessName,
    this.location,
    required this.uid,
    required this.userType,
     required this.timestamp,
  });

  Map<String, dynamic> toJsone(String idd) => {
        'entrepreneurName': entrepreneurName,
        'entrepreneurNumber': entrepreneurNumber,
        'entrepreneurEmail': entrepreneurEmail,
        'entrepreneurPassword': entrepreneurPassword,
        'id': idd,
        'profileImage': image,
        'businessName': businessName,
        'location': location,
        'uid': uid,
        'userType': userType,
         'timestamp': timestamp.toIso8601String(),
      };

  factory EnterprenurModel.fromJsone(Map<String, dynamic> json) {
    return EnterprenurModel(
      entrepreneurName: json['entrepreneurName'],
      entrepreneurNumber: json['entrepreneurNumber'],
      entrepreneurEmail: json['entrepreneurEmail'],
      entrepreneurPassword: json['entrepreneurPassword'],
      id: json['id'],
      image: json['profileImage'],
      businessName: json['businessName'],
      location: json['location'],
      uid: json['uid'],
      userType: json['userType'],
       timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
