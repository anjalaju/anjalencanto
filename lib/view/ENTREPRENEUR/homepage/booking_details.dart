import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/userbookingmodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<FunctionProvider>(
              builder: (context, helper, child) {
                return StreamBuilder(
                  stream:
                      helper.getAllbookingenterprenur(auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<BookingModle> booklist = [];

                    booklist = snapshot.data!.docs.map((e) {
                      return BookingModle.fromjsone(
                          e.data() as Map<String, dynamic>);
                    }).toList();
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height / 1.3,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Center(
                              child: Image.asset('images/no booking.jpg')),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      // return booklist.isEmpty
                      //     ? Center(
                      //         child: Text('No BOOKING FOUND'),
                      //       )
                      //     :
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: GridView.builder(
                          controller: ScrollController(),
                          itemCount: booklist.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            final eventid = booklist[index].eventid;

                            Stream imageget() {
                              return db
                                  .collection('AddEvent')
                                  .doc(eventid)
                                  .snapshots();
                            }

                            final uid = booklist[index].userid;

                            Stream userget() {
                              return db
                                  .collection('firebase')
                                  .doc(uid)
                                  .snapshots();
                            }

                            return Container(
                              // width: Helper.W(context) * .080,
                              // height: Helper.h(context) * .250,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.indigo[100]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Helper.W(context) * .150,
                                    height: Helper.h(context) * .100,
                                    child: StreamBuilder(
                                      stream: imageget(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        }
                                        return Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4,),
                                            child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                child: Image.network(
                                                    fit: BoxFit.cover,
                                                    snapshot.data['image']),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('AddEvent')
                                        .doc(booklist[index].eventid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return Center(
                                            child: Text(
                                          'Event not found.',
                                          style: TextStyle(fontSize: 7),
                                        ));
                                      }
                                      final event = snapshot.data!;
                                      return Text(
                                          ' Event Name: ${event['eventname']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),);
                                    },
                                  ),
                                  // Text(
                                  //   ' Event Name :${booklist[index].name}',
                                  //   style: const TextStyle(fontSize: 10),
                                  // ),
                                  StreamBuilder(
                                    stream: userget(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      return Text(
                                          ' Booking User Name: ${snapshot.data['User_Name']}',
                                          style: const TextStyle(fontSize: 10.5));
                                    },
                                  ),

                                  Text(' Date: ${booklist[index].date}',
                                      style: const TextStyle(fontSize: 10.5)),
                                  Text(' Ph No: ${booklist[index].phonenumber}',
                                      style: const TextStyle(fontSize: 10.5)),
                                  Text(
                                      ' Discription: ${booklist[index].discription}',
                                      style: const TextStyle(fontSize: 10.5)),
                                
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
