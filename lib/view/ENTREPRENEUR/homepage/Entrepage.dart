import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Entreentreprenuer extends StatefulWidget {
  const Entreentreprenuer({super.key});

  @override
  State<Entreentreprenuer> createState() => _EntreentreprenuerState();
}

class _EntreentreprenuerState extends State<Entreentreprenuer> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final bisname = TextEditingController();
  final location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final helperprovdr = Provider.of<FunctionProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder(
      future: helperprovdr.getEnterprenurdata(auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final endata = helperprovdr.signleentr;

        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/entrepropic.jpg"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await helperprovdr.imagePicker();
                      await helperprovdr
                          .updatProfielonly(
                              auth.currentUser!.uid, helperprovdr.url)
                          .then(
                            (value) => helperprovdr.url = null,
                          );
                    },
                    child: endata!.image == null || endata!.image!.isEmpty
                        ? Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: const DecorationImage(
                                    image: AssetImage('images/propic.png'),
                                    fit: BoxFit.cover),
                                // borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 2,
                                )),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons
                                            .camera_alt, // You can use any icon you like
                                        size: 24, // Adjust the size of the icon
                                        color: Colors
                                            .white, // Adjust the color of the icon
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(endata!.image.toString()),
                                    fit: BoxFit.cover),
                                // borderRadius: BorderRadius.circular(50),
                              
                                border: Border.all(
                                  width: 2,
                                )),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons
                                            .camera_alt, // You can use any icon you like
                                        size: 24, // Adjust the size of the icon
                                        color: Colors
                                            .white, // Adjust the color of the icon
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                // const Center(child: const Text("Add profile Picture")),
                const Text("EnterprenurName"),
                const SizedBox(height: 7),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(
                            endata!.entrepreneurName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          leading: const Icon(Icons.person),
                          iconColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Mobile Number"),
                const SizedBox(height: 7),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(endata.entrepreneurNumber),
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          leading: const Icon(Icons.call),
                          iconColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Email"),
                const SizedBox(height: 7),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(
                            endata.entrepreneurEmail,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          leading: const Icon(Icons.email),
                          iconColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                const Text("Business name"),
                const SizedBox(height: 7),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        // height: 50,
                        child: ListTile(
                          title: endata.businessName!.isEmpty
                              ? TextFormField(
                                  controller: bisname,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                )
                              : Text(endata.businessName.toString()),
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          leading: const Icon(Icons.apartment),
                          iconColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Location"),
                const SizedBox(height: 7),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        // height: 50,
                        child: ListTile(
                          title: endata.location!.isEmpty
                              ? TextFormField(
                                  controller: location,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                )
                              : Text(endata.location.toString()),
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          leading: const Icon(Icons.location_on_sharp),
                          iconColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Helper.h(context) * .020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        helperprovdr.updatProfiel(
                          auth.currentUser!.uid,
                          bisname.text,
                          location.text,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Helper.W(context) * .50,
                        height: Helper.h(context) * .060,
                        // color: Colors.red,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                          color: Colors.pink,
                          border: Border.all(),
                        ),
                        child: const Text('Update add',style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    )));
  }
}
