class EventModel {
  String eventName;
  String eventPlace;
  String eventmainCategory;
  String eventSubcategory;
  String discription;
  String startingPriceFrom;
  String Image;
  String? id;
  String enterprenurid;
  String phonenumber;

  EventModel({
    required this.eventName,
    required this.eventPlace,
    required this.eventmainCategory,
    required this.eventSubcategory,
    this.id,
    required this.enterprenurid,
    required this.Image,
    required this.discription,
    required this.startingPriceFrom,
    required this.phonenumber,
  });

  Map<String, dynamic> toJson(idd) => {
        'eventname': eventName,
        'eventplace': eventPlace,
        'eventmaincategory': eventmainCategory,
        'eventsubcategory': eventSubcategory,
        'eventdiscription': discription,
        'image': Image,
        'startingprice': startingPriceFrom,
        'enterprenurid': enterprenurid,
        'id': idd,
        'phonenumber': phonenumber,
      };

  factory EventModel.fromJsone(Map<String, dynamic> jsone) {
    return EventModel(
      eventName: jsone['eventname'],
      eventPlace: jsone['eventplace'],
      eventmainCategory: jsone['eventmaincategory'],
      eventSubcategory: jsone['eventsubcategory'],
      enterprenurid: jsone['enterprenurid'],
      Image: jsone['image'],
      discription: jsone['eventdiscription'],
      startingPriceFrom: jsone['startingprice'],
      phonenumber: jsone['phonenumber'],
      id: jsone['id'],
    );
  }
}
