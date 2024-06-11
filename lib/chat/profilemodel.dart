class Myprofilemodel {
  String firstname;
  // String secondname;

  // int age;

  String? id;
  String email;
  String url;

  Myprofilemodel({
    required this.firstname,
    // required this.secondname,
    // required this.age,
    this.id,
    required this.email,
    required this.url,
  });

  Map<String, dynamic> data(docId) => {
        "First Name": firstname,
        // "Second Name": secondname,
        "Id": docId,
        "Email": email,
        "image": url,
        // "age": age,
      };

  factory Myprofilemodel.fromData(Map<String, dynamic> i) {
    return Myprofilemodel(
      firstname: i["First Name"],
      // secondname: i["Second Name"],
      // age: i["age"],
      id: i["Id"],
      email: i["Email"],
      url: i["image"],
    );
  }
}
