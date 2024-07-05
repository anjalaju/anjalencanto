import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/model/likepostmodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/USER/Drawer/Shotlist1.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';

class Shortlist extends StatefulWidget {
  const Shortlist({super.key});

  @override
  State<Shortlist> createState() => _ShortlistState();
}

class _ShortlistState extends State<Shortlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wishlist',
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
          //   // IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          //   // IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Helper.h(context) * .020,
              ),
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getpostlike(auth.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      List<Likepostmodel> list = [];

                      list = snapshot.data!.docs.map((e) {
                        return Likepostmodel.fromjsone(
                            e.data() as Map<String, dynamic>);
                      }).toList();

                      return list.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height / 1.3,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    // child: const Text('No favorite'),
                                    child: Container(
                                      height: 100,
                                      color: Colors.black,
                                      child: Image.asset(
                                        'images/nofavorite.webp',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,),
                            child: GridView.builder(controller: ScrollController(),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Helper.W(context) * .020,
                                ),
                                shrinkWrap: true,
                                itemCount: list.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemBuilder: (context, index) {
                                  final post = list[index].postid;
                            
                                  Stream<DocumentSnapshot> poststrem = db
                                      .collection('AddEvent')
                                      .doc(post)
                                      .snapshots();
                            
                                  return StreamBuilder(
                                    stream: poststrem,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      var eventData = snapshot.data!.data()
                                          as Map<String, dynamic>;
                                      EventModel eventModel =
                                          EventModel.fromJsone(eventData);
                            
                                      // EventModel eventModel = EventModel.fromJsone(poststrem)
                            
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: Helper.W(context) * .050,
                                          height: Helper.W(context) * .020,
                                          // color: Colors.red,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                            border: Border.all(width: 2,color: Colors.pink),color: Color.fromARGB(255, 183, 194, 203)
                                          ),
                                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: Helper.W(context) * .250,
                                                height: Helper.h(context) * .120,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    eventModel.Image,
                                                  ),
                                                )),
                                              ),
                                              // Text(eventModel.eventName),
                                              SizedBox(height: 3,),
                                              Text(
                                                   eventModel.eventName,
                                                    style: GoogleFonts.lato(
                                                     
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),SizedBox(height: 8,),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Shortlistphotographer(
                                                          eventModel: eventModel,
                                                        ),
                                                      ));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: Helper.W(context) * .250,
                                                  height:
                                                      Helper.W(context) * .050,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    color: Colors.black,
                                                    border: Border.all(),
                                                  ),
                                                  child: Text(
                                                    'View Details',
                                                    style: GoogleFonts.lato(
                                                     
                                                      fontSize: 9,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                          );
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}


// getpostlike


// 