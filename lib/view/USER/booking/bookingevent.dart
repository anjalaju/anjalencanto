import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/model/userbookingmodel.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class BookEventScren extends StatelessWidget {
  const BookEventScren({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(id) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ARE YOU SURE CONFORM YOUR EVENT CLOSE'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CLOSE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      helper.deleteBooking(id);

                      Navigator.of(context).pop();
                    },
                  );
                },
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking list',
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
              builder: (context, instance, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: instance.getBookingevent(auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<BookingModle> list = [];

                    list = snapshot.data!.docs.map((e) {
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.separated(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final doc = list[index].eventid;

                            final data =
                                db.collection('AddEvent').doc(doc).snapshots();

                            return Container(
                              color: const Color.fromARGB(255, 203, 219, 233),
                              width: MediaQuery.of(context).size.width,
                              // height: 150,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          StreamBuilder(
                                            stream: data,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.indigo),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // color: Colors.red,
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data!['image']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FutureBuilder<DocumentSnapshot>(
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('AddEvent')
                                                    .doc(list[index].eventid)
                                                    .get(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  if (!snapshot.hasData ||
                                                      !snapshot.data!.exists) {
                                                    return const Center(
                                                        child: Text(
                                                      'Event not found.',
                                                      style: TextStyle(
                                                          fontSize: 7),
                                                    ));
                                                  }
                                                  final event = snapshot.data!;
                                                  return Text(
                                                    'Event Name: ${event['eventname']}',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  );
                                                },
                                              ),
                                              Text(
                                                'PAYMNET STATUS : ${list[index].paymentstatus}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'BOOKING DATE :  ${list[index].date}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'EVENT PRICE : ${list[index].eventprice}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          height: 38,
                                          width: 38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red,
                                            border: Border.all(
                                                color: Colors.indigo, width: 2),
                                          ),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () async {
                                                await _showMyDialog(
                                                    list[index].id);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 2,
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
