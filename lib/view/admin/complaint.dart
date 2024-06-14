import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addreview.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Complaintadmin extends StatefulWidget {
  const Complaintadmin({super.key});

  @override
  State<Complaintadmin> createState() => _ComplaintadminState();
}

class _ComplaintadminState extends State<Complaintadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            Container(
              width: Helper.W(context) / 1,
              // height: Helper.h(context) * .250,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.h(context) * .050,
                  ),
                  Consumer<FunctionProvider>(
                    builder: (context, helper, child) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: helper.getAllcomplaint(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }


                List<ComplaintModel> reviews = snapshot.data!.docs.map((doc) {
          return ComplaintModel.fromjsone(doc.data() as Map<String, dynamic>);
        }).toList();
                          

                          return ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: Helper.W(context) * .050),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              return Material(
                                elevation: 4,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                'complait TITLE :${reviews[index].complaint}'),
                                                SizedBox(
                                                  height: Helper.h(context)*.020,
                                                ),

                                                Text('complait User id  :${reviews[index].uid}'),
                                                 SizedBox(
                                                  height: Helper.h(context)*.020,
                                                ),
                                                 
                                              Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.calendar_today,
                                                          size: 18,
                                                          color: Colors.indigo),
                                                      const SizedBox(
                                                          width:
                                                              4), // Add spacing between icon and text
                                                      Text(
                                                        'Date: ${DateFormat('yyyy-MM-dd').format(reviews[index].timestamp.toDate())}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          4), // Add spacing between date and time
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.access_time,
                                                          size: 18,
                                                          color: Colors.indigo),
                                                      const SizedBox(
                                                          width:
                                                              4), // Add spacing between icon and text
                                                      Text(
                                                        'Time: ${DateFormat('HH:mm').format(reviews[index].timestamp.toDate())}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
 
                                               db.collection('Alert').doc(reviews[index].id).delete();
                                               setState(() {
                                                 
                                               });
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Helper.h(context) * .020,
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
