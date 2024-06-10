class NotificationModel {
  String notificationtitile;
  String notificationSubtitile;
  String? id;

  NotificationModel({
    required this.notificationtitile,
    required this.notificationSubtitile,
    this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'Notificationtitle': notificationtitile,
        'Notificationsubtitle': notificationSubtitile,
        'id': idd,
      };

  factory NotificationModel.fromjsone(Map<String, dynamic> jsone) {
    return NotificationModel(
      notificationtitile: jsone['Notificationtitle'],
      notificationSubtitile: jsone['Notificationsubtitle'],
      id: jsone['id'],
    );
  }
}
