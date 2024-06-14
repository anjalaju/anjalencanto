import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final complaint = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Complaint',
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
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            color: Colors.black,
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const Shortlist()));
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  "Enter your Complaints  !   ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Container(

              //   height:  90,
              //   padding: const EdgeInsets.all(10),
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.red)),
              // )

              TextFormField(
                controller: complaint,
                maxLines: 3,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF0000)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: ("           Enter here....."),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ewquired';
                  }
                },
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Consumer<FunctionProvider>(
                    builder: (context, helper, child) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10))),
                            minimumSize:
                                MaterialStateProperty.all(const Size(150, 50)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFE693A))),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder:(context) => loginnotification()));
                          helper
                              .addCompalint(ComplaintModel(
                            complaint: complaint.text,
                            uid: auth.currentUser!.uid,
                             timestamp: Timestamp.now(),
                          ))
                              .then((value) {
                            SuccesToast(context, 'add Complaint  ');
                            clear();
                          });
                        },
                        child: const Text(
                          "Send",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ));
  }

  clear() {
    complaint.clear();
  }
}
