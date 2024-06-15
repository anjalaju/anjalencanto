// class NotificationModel {
//   String notificationtitile;
//   String notificationSubtitile;
//   String? id;

//   NotificationModel({
//     required this.notificationtitile,
//     required this.notificationSubtitile,
//     this.id,
//   });

//   Map<String, dynamic> tojsone(idd) => {
//         'Notificationtitle': notificationtitile,
//         'Notificationsubtitle': notificationSubtitile,
//         'id': idd,
//       };

//   factory NotificationModel.fromjsone(Map<String, dynamic> jsone) {
//     return NotificationModel(
//       notificationtitile: jsone['Notificationtitle'],
//       notificationSubtitile: jsone['Notificationsubtitle'],
//       id: jsone['id'],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String notificationtitile;
  String notificationSubtitile;
  String? id;
  Timestamp timestamp; // Add timestamp field

  NotificationModel({
    required this.notificationtitile,
    required this.notificationSubtitile,
    this.id,
    required this.timestamp,
  });

  Map<String, dynamic> tojsone(idd) => {
        'Notificationtitle': notificationtitile,
        'Notificationsubtitle': notificationSubtitile,
        'id': idd,
        'timestamp': timestamp,
      };

  factory NotificationModel.fromjsone(Map<String, dynamic> jsone) {
    return NotificationModel(
      notificationtitile: jsone['Notificationtitle'],
      notificationSubtitile: jsone['Notificationsubtitle'],
      id: jsone['id'],
      timestamp: jsone['timestamp'],
    );
  }
}
