// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:main_project/controller/FunctionProvider.dart';
// import 'package:main_project/model/addreview.dart';
// import 'package:main_project/model/complaint.dart';
// import 'package:main_project/utils/String.dart';
// import 'package:provider/provider.dart';

// class Complaintadmin extends StatefulWidget {
//   const Complaintadmin({super.key});

//   @override
//   State<Complaintadmin> createState() => _ComplaintadminState();
// }

// class _ComplaintadminState extends State<Complaintadmin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               width: Helper.W(context) / 1,
//               // height: Helper.h(context) * .250,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: Helper.h(context) * .050,
//                   ),
//                   Consumer<FunctionProvider>(
//                     builder: (context, helper, child) {
//                       return StreamBuilder<QuerySnapshot>(
//                         stream: helper.getAllcomplaint(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           }

//                           List<ComplaintModel> reviews =
//                               snapshot.data!.docs.map((doc) {
//                             return ComplaintModel.fromjsone(
//                                 doc.data() as Map<String, dynamic>);
//                           }).toList();

//                           return ListView.separated(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Helper.W(context) * .050),
//                             shrinkWrap: true,
//                             physics: BouncingScrollPhysics(),
//                             itemCount: reviews.length,
//                             itemBuilder: (context, index) {
//                               return Material(
//                                 elevation: 4,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                                 'Complaint  :${reviews[index].complaint}'),
//                                             SizedBox(
//                                               height: Helper.h(context) * .020,
//                                             ),

//                                             Text(
//                                                 'Complaint User id  :${reviews[index].uid}'),
//                                             SizedBox(
//                                               height: Helper.h(context) * .020,
//                                             ),
//                                                Text(
//                                                 'Complaint  :${reviews[index].complaint}'),

//                                             Text(
//                                                 'Complaint User id  :${reviews[index].uid}'),
//                                             SizedBox(
//                                               height: Helper.h(context) * .020,
//                                             ),

//                                             Row(
//                                               children: [
//                                                 const Icon(Icons.calendar_today,
//                                                     size: 18,
//                                                     color: Colors.indigo),
//                                                 const SizedBox(
//                                                     width:
//                                                         4), // Add spacing between icon and text
//                                                 Text(
//                                                   'Date: ${DateFormat('yyyy-MM-dd').format(reviews[index].timestamp.toDate())}',
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                                 height:
//                                                     4), // Add spacing between date and time
//                                             Row(
//                                               children: [
//                                                 const Icon(Icons.access_time,
//                                                     size: 18,
//                                                     color: Colors.indigo),
//                                                 const SizedBox(
//                                                     width:
//                                                         4), // Add spacing between icon and text
//                                                 Text(
//                                                   'Time: ${DateFormat('HH:mm').format(reviews[index].timestamp.toDate())}',
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         IconButton(
//                                             onPressed: () {
//                                               db
//                                                   .collection('Alert')
//                                                   .doc(reviews[index].id)
//                                                   .delete();
//                                               setState(() {});
//                                             },
//                                             icon: Icon(Icons.delete))
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) {
//                               return SizedBox(
//                                 height: Helper.h(context) * .020,
//                               );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ],
//         )
//       ],
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/controller/FunctionProvider.dart';
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
      appBar: AppBar(
            backgroundColor: const Color(0xffE72245),
          title: const Text(
            'Complaints',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          // backgroundColor: Colors.transparent,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: Helper.h(context) * .050,
              ),
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getAllcomplaint(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<ComplaintModel> list = [];

                      list = snapshot.data!.docs.map((e) {
                        return ComplaintModel.fromjsone(
                            e.data() as Map<String, dynamic>);
                      }).toList();

                      if (snapshot.hasData) {
                        return list.isEmpty
                            ? const Center(
                                child: Text('No alert '),
                              )
                            : Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    final doc = list[index].uid;
                              
                                    final userdata = db
                                        .collection('firebase')
                                        .doc(doc)
                                        .snapshots();
                              
                                    return Container(
                                      // height: 119,
                                      width: 373,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color:
                                              Color.fromARGB(255, 185, 228, 183)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   'Timestamp: ${DateFormat('yyyy-MM-dd HH:mm').format(list[index].timestamp.toDate())}',
                                            //   style: TextStyle(
                                            //     color: Colors.black,
                                            //     fontSize: 14,
                                            //   ),
                                            // ),
                              
                                            Text(
                                              list[index].complaint,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            StreamBuilder(
                                              stream: userdata,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            ' Name: ${snapshot.data!['User_Name']}'),
                                                        Text(
                                                            ' Phno: ${snapshot.data!['Mobile_No']}'),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                size: 18,
                                                                color: Colors
                                                                    .indigo),
                                                            const SizedBox(
                                                                width:
                                                                    4), // Add spacing between icon and text
                                                            Text(
                                                              'Date: ${DateFormat('yyyy-MM-dd').format(list[index].timestamp.toDate())}',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.black,
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
                                                                color: Colors
                                                                    .indigo),
                                                            const SizedBox(
                                                                width:
                                                                    4), // Add spacing between icon and text
                                                            Text(
                                                              'Time: ${DateFormat('HH:mm').format(list[index].timestamp.toDate())}',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Id: ${list[index].uid}',
                                                          style: TextStyle(
                                                              color: Colors.orange),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7),
                                                        color: Colors.red,
                                                      ),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            db
                                                                .collection(
                                                                    'Alert')
                                                                .doc(list[index]
                                                                    .id)
                                                                .delete();
                                                            setState(() {});
                                                          },
                                                          icon:
                                                              Icon(Icons.delete,color: Colors.white,)),
                                                    )
                                                  ],
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 30,
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
      ),
    );
  }
}
