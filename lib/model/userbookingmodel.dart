class BookingModle {
  String name;
  String email;
  String phonenumber;
  String date;
  String discription;
  String eventid;
  String userid;
  String? id;
  String eventprice;
  String paymentstatus;

  BookingModle({
    required this.name,
    required this.email,
    required this.phonenumber,
    required this.date,
    required this.discription,
    required this.eventid,
    required this.userid,
    required this.paymentstatus,
    required this.eventprice,
      this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'Name': name,
        'Email': email,
        'Phonenumber': phonenumber,
        'Data': date,
        'Discription': discription,
        'Eventid': eventid,
        'Userid': userid,
        'id': idd,
        'PaymentStatus':paymentstatus,
        'eventprice':eventprice,
      };

  factory BookingModle.fromjsone(Map<String, dynamic> jsone) {
    return BookingModle(
      name: jsone['Name'],
      email: jsone['Email'],
      phonenumber: jsone['Phonenumber'],
      date: jsone['Data'],
      discription: jsone['Discription'],
      eventid: jsone['Eventid'],
      userid: jsone['Userid'],
      paymentstatus: jsone['PaymentStatus'],
      id: jsone['id'],
      eventprice: jsone['eventprice'],
    );
  }
}
