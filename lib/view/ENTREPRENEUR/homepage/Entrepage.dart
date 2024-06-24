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
          return Center(
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
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await helperprovdr.imagePicker();
                      log(auth.currentUser!.uid);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(helperprovdr.url.toString())),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                          )),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 60,
                            right: 40,
                            child: IconButton(
                              onPressed: () async {
                                // await helperprovdr.imagePicker();
                              },
                              icon: const Icon(Icons.add),
                              iconSize: 30,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(child: const Text("Add profile Picture")),
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.person),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
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
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.call),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.email),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
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
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                )
                              : Text(endata.businessName.toString()),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.apartment),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
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
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                )
                              : Text(endata.location.toString()),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.location_on_sharp),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
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
                        helperprovdr.updatProfielonly(
                            auth.currentUser!.uid,);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Helper.W(context) * .50,
                        height: Helper.h(context) * .060,
                        // color: Colors.red,
                        decoration: BoxDecoration(

                          border: Border.all(),
                        ),
                        child: Text('Update add'),
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
