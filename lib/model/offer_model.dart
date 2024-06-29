class Offermodel {
  String image;
  String? id;
  DateTime timestamp;
  String uid;
  Offermodel({
    required this.image,
    this.id,
    required this.timestamp,
    required this.uid,
  });

  Map<String, dynamic> tomap() => {
        "Image": image,
        'id': id,
        "timestamp": timestamp.toIso8601String(),
        'uid': uid,
      };
  factory Offermodel.fromMap(Map<String, dynamic> data) {
    return Offermodel(
        image: data["Image"],
        id: data["id"],
        timestamp: DateTime.parse(data["timestamp"]),
        uid: data['uid']);
  }
}
