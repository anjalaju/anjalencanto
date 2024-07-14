 
class Donatemodel {
  String name;
  String age;
  String itemname;
  String image;
  String contactnumber;
  String place;
  String numberofitem;
  String? id;
  String selected;
  String uid;
   DateTime timestamp;

  Donatemodel({
    required this.name,
    required this.age,
    required this.itemname,
    required this.image,
    required this.contactnumber,
    required this.place,
    required this.numberofitem,
    this.id,
    required this.selected,
    required this.uid,
     required this.timestamp,
  });

  Map<String, dynamic> tojasone(idd) => {
        'Name': name,
        'Age': age,
        'ItemName': itemname,
        'Image': image,
        'ContactNumber': contactnumber,
        'Place': place,
        'NumberOfitems': numberofitem,
        'id': idd,
        'Selected':selected,
        'uid':uid,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Donatemodel.fromjsone(Map<String, dynamic> jsone) {
    return Donatemodel(
      name: jsone['Name'],
      age: jsone['Age'],
      itemname: jsone['ItemName'],
      image: jsone['Image'],
      contactnumber: jsone['ContactNumber'],
      place: jsone['Place'],
      numberofitem: jsone['NumberOfitems'],
      id: jsone['id'],
      selected: jsone['Selected'],
      uid: jsone['uid'],
       timestamp: DateTime.parse(jsone['timestamp']),
    );
  }
}
