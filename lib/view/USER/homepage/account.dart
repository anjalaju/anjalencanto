import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/view/USER/homepage/EDIT/age.dart';
import 'package:main_project/view/USER/homepage/EDIT/editmobileno.dart';
import 'package:main_project/view/USER/homepage/EDIT/place.dart';
import 'package:main_project/view/USER/homepage/EDIT/usernameedit.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({super.key});

  @override
  State<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String id = _auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            thickness: 2,
            color: Colors.black,
            height: 1,
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //   ),
        //   color: Colors.black,
        // ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => const Shortlist()));
        //       },
        //       icon: const Icon(Icons.favorite)),
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => Chatpage(),
        //         ));
        //       },
        //       icon: const Icon(Icons.chat_outlined))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: _firestore.collection('firebase').doc(id).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      print('No data available');
                    }

                    DocumentSnapshot<Map<String, dynamic>> data =
                        snapshot.data!;
                    if (!data.exists) {
                      print('Document does not exist');
                    }

                    // Check if 'image' field exists and is not null in the document
                    if (!data.data()!.containsKey('Image') ||
                        data.data()!['Image'] == null) {
                      print('Image URL not found');
                    }

                    String imageUrl = data.data()!['Image'];

                    return Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 91,
                        child: CircleAvatar(
                          radius: 87,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Text(
                  //   "Anjal",
                  //   style: TextStyle(
                  //     fontSize: 35,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  StreamBuilder(
                    stream: _firestore
                        .collection("firebase")
                        .where("Id", isEqualTo: _auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (documents.isNotEmpty) {
                          final username = documents[0].get("User_Name");
                          if (username != null) {
                            return Text(
                              "$username",
                              style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            // Handle the case where username is null
                            return const Text(
                              ",",
                              style: TextStyle(
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            );
                          }
                        }
                      }
                      return const CircularProgressIndicator(); // Placeholder for loading state
                    },
                  ),
                  InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const NameEditPage()));
                  },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1.5,
                        horizontal: 5,
                      ),
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Column(
                        children: [
                          Text("Edit"),
                          Icon(
                            Icons.edit,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: _firestore
                    .collection("firebase")
                    .where("Id", isEqualTo: _auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    if (documents.isNotEmpty) {
                      final email = documents[0].get("Email");
                      return Center(child: Text("Email: ${email ?? ""}"));
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 20),
              const Text("Mobile number",style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: _firestore
                        .collection("firebase")
                        .where("Id", isEqualTo: _auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (documents.isNotEmpty) {
                          final mobile = documents[0].get("Mobile_No");
                          return Text(mobile ?? "");
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const EditMobileNum())));
                    },
                    child: Container(
                      width: 30,
                      child: Image.asset(
                        'images/OIP.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              const Text("Place",style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: _firestore
                        .collection("firebase")
                        .where("Id", isEqualTo: _auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (documents.isNotEmpty) {
                          final place = documents[0].get("Place");
                          return Text(place ?? "");
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const PlaceEditPage())));
                    },
                    child: Container(
                      width: 30,
                      child: Image.asset(
                        'images/OIP.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              const Text("Age",style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: _firestore
                        .collection("firebase")
                        .where("Id", isEqualTo: _auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (documents.isNotEmpty) {
                          final age = documents[0].get("Age");
                          return Text(age.toString() ?? "");
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const AgeEditPage())));
                    },
                    child: Container(
                      width: 30,
                      child: Image.asset(
                        'images/OIP.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
