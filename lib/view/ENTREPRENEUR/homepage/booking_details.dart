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
        title: Text('BOOKING DETAILS'),
      ),
      body: Column(
        children: [
          Consumer<FunctionProvider>(
            builder: (context, helper, child) {
              return StreamBuilder(
                stream: helper.getAllbookingenterprenur(auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<BookingModle> booklist = [];

                  booklist = snapshot.data!.docs.map((e) {
                    return BookingModle.fromjsone(
                        e.data() as Map<String, dynamic>);
                  }).toList();

                  if (snapshot.hasData) {
                    return booklist.isEmpty
                        ? Center(
                            child: Text('No BOOKING FOUND'),
                          )
                        : GridView.builder(
                            itemCount: booklist.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              // childAspectRatio: 5,
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
                                height: Helper.h(context) * .250,
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: Helper.W(context) * .100,
                                      height: Helper.h(context) * .100,
                                      child: StreamBuilder(
                                        stream: imageget(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          }
                                          return Image.network(
                                              fit: BoxFit.cover,
                                              snapshot.data['image']);
                                        },
                                      ),
                                    ),
                                    Text('EVENT NAME :${booklist[index].name}'),
                                    StreamBuilder(
                                      stream: userget(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        }
                                        return Text(
                                            'BOOKING USER NAME:${snapshot.data['User_Name']}');
                                      },
                                    ),
                                    Text(
                                        'EVENT DICS :${booklist[index].discription}'),
                                  ],
                                ),
                              );
                            },
                          );
                  }
                  return Container();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
