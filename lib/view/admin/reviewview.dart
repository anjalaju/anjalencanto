// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:main_project/controller/FunctionProvider.dart';
// import 'package:main_project/model/addreview.dart';
// import 'package:main_project/utils/String.dart';
// import 'package:provider/provider.dart';

// class ReviewViewAdmin extends StatefulWidget {
//   const ReviewViewAdmin({super.key});

//   @override
//   State<ReviewViewAdmin> createState() => _ReviewViewAdminState();
// }

// class _ReviewViewAdminState extends State<ReviewViewAdmin> {
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
//                         stream: helper.getReview(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const CircularProgressIndicator();
//                           }

//                           List<AddReview> reviews =
//                               snapshot.data!.docs.map((doc) {
//                             return AddReview.fromjsone(
//                                 doc.data() as Map<String, dynamic>);
//                           }).toList();

//                           return ListView.separated(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Helper.W(context) * .050),
//                             shrinkWrap: true,
//                             physics: const BouncingScrollPhysics(),
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
//                                         Column(
//                                           children: [
//                                             Text(
//                                                 'Review TITLE :${reviews[index].review}'),
//                                           ],
//                                         ),
//                                         IconButton(
//                                             onPressed: () {
//                                               db
//                                                   .collection('AddReview')
//                                                   .doc(reviews[index].id)
//                                                   .delete();
//                                               setState(() {});
//                                             },
//                                             icon: const Icon(Icons.delete))
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addreview.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class ReviewViewAdmin extends StatefulWidget {
  const ReviewViewAdmin({super.key});

  @override
  State<ReviewViewAdmin> createState() => _ReviewViewAdminState();
}

class _ReviewViewAdminState extends State<ReviewViewAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
            backgroundColor: const Color(0xffE72245),
          title: const Text(
            'Reviews',
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
                  return StreamBuilder<QuerySnapshot>(
                    stream: helper.getReview(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      //      if (snapshot.hasError) {
                      //   return Center(
                      //     child: Text('Error: ${snapshot.error}'),
                      //   );
                      // }

                      // if (!snapshot.hasData || snapshot.data == null) {
                      //   return Center(
                      //     child: Text('No data available'),
                      //   );
                      // }

                      List<AddReview> list = [];

                      list = snapshot.data!.docs.map((e) {
                        return AddReview.fromjsone(
                            e.data() as Map<String, dynamic>);
                      }).toList();

                      if (snapshot.hasData) {
                        return list.isEmpty
                            ? Center(
                                child: Text('No alert '),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ListView.separated(
                                  controller: ScrollController(),
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    final doc = list[index].uid;

                                    final data = db
                                        .collection('firebase')
                                        .doc(doc)
                                        .snapshots();

                                    return Container(
                                      // height: 119,
                                      width: 373,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:Color(0xffBBE2EC)),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  list[index].review,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                StreamBuilder(
                                                  stream: data,
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }

                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            'Name: ${snapshot.data!['User_Name']}'),
                                                        Text(
                                                            'Phno: ${snapshot.data!['Mobile_No']}'),
                                                      ],
                                                    );
                                                  },
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
                                                      'Date: ${DateFormat('yyyy-MM-dd').format(list[index].timestamp.toDate())}',
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
                                                      'Time: ${DateFormat('HH:mm').format(list[index].timestamp.toDate())}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
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
                                                    BorderRadius.circular(7),
                                                color: Colors.red,
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    db
                                                        .collection('AddReview')
                                                        .doc(list[index].id)
                                                        .delete();
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
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
