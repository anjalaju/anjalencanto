// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:main_project/controller/FunctionProvider.dart';
// import 'package:main_project/model/notificationmodel.dart';
// import 'package:main_project/utils/String.dart';
// import 'package:provider/provider.dart';

// class notificationpage extends StatefulWidget {
//   const notificationpage({super.key});

//   @override
//   State<notificationpage> createState() => _notificationpageState();
// }

// class _notificationpageState extends State<notificationpage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'Notification',
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
//         ),
//         backgroundColor: Colors.transparent,
//         bottom: const PreferredSize(
//           preferredSize: Size.fromHeight(1),
//           child: Divider(
//             thickness: 2,
//             color: Colors.black,
//             height: 1,
//           ),
//         ),
//         // leading: IconButton(
//         //   onPressed: () {
//         //     Navigator.of(context).pop();
//         //   },
//         //   icon: const Icon(
//         //     Icons.arrow_back_ios_new,
//         //   ),
//         //   color: Colors.black,
//         // ),
//         // actions: [
//         //   IconButton(onPressed: () {
//         //                   Navigator.push(context,
//         //             MaterialPageRoute(builder: (context) => const Shortlist()));
//         //   }, icon: const Icon(Icons.favorite)),
//         //   IconButton(onPressed: () {
//         //      Navigator.of(context).push(MaterialPageRoute(
//         //           builder: (context) => Chatpage(),
//         //         ));
//         //   }, icon: const Icon(Icons.chat_outlined))
//         // ],
//       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 30),
// //           child: Column(
// //             children: [
// //               Consumer<FunctionProvider>(
// //                 builder: (context, helper, child) {
// //                   return StreamBuilder(
// //                     stream: helper.getNotificationall().asStream(),
// //                     builder: (context, snapshot) {

// //                       final list=   helper.allnoti;
// //                       return list.isEmpty
// //                           ? Center(
// //                               child: Text('no data'),
// //                             )
// //                           : Expanded(
// //                             child: ListView.separated(
// //                                 shrinkWrap: true,
// //                                 itemCount: list.length,
// //                                 itemBuilder: (context, index) {
// //                                   return Material(
// //                                     color: Colors.grey.shade100,
// //                                     elevation: 4,
// //                                     child: Container(
// //                                       decoration: BoxDecoration(
// //                                           // color: Colors.red
// //                                           ),
// //                                       width: double.infinity,
// //                                       // height: Helper.h(context) * .050,
// //                                       child: Column(
// //                                         children: [

// //                                           ListTile(
// //                                             leading:Text(list[index].notificationtitile),
// //                                             subtitle:Text(list[index].notificationSubtitile),
// //                                           )
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   );
// //                                 },
// //                                 separatorBuilder: (context, index) {
// //                                   return SizedBox(
// //                                     height: Helper.h(context) * .050,
// //                                   );
// //                                 },
// //                               ),
// //                           );
// //                     },
// //                   );
// //                 },
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//  body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           children: [
//             Consumer<FunctionProvider>(
//               builder: (context, helper, child) {
//                 return StreamBuilder(
//                   stream: helper.getNotificationall().asStream(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }

//                     final list = helper.allnoti;

//                     if (list.isEmpty) {
//                       return Center(
//                         child: Text('No notifications'),
//                       );
//                     }

//                     return Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: ListView.separated(
//                           itemCount: list.length,
//                           itemBuilder: (context, index) {
//                             return Material(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                               color: Colors.deepOrange,
//                               elevation: 4,
//                               child: ListTile(
//                                 title: Text(list[index].notificationtitile),
//                                 subtitle: Text(list[index].notificationSubtitile),
//                               ),
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return SizedBox(height: 10); // Adjust height as needed
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/utils/String.dart';

class notificationpage extends StatefulWidget {
  @override
  _notificationpageState createState() => _notificationpageState();
}

class _notificationpageState extends State<notificationpage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = _firestore
        .collection('Notiication')
        .where('Email', isEqualTo: auth.currentUser!.email).orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffE72245),
      //   title: const Text('NOTIFICATIONS'),
      // ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Notifications',
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
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Image.asset('images/no notificaation.jpeg')),
            );
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.separated(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = documents[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.indigo,
                      title: Text(
                        "Title: ${data['Notificationtitle']}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subtitle: ${data['Notificationsubtitle']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 18, color: Colors.red),
                              const SizedBox(
                                  width:
                                      4), // Add spacing between icon and text
                              Text(
                                'Date: ${DateFormat('yyyy-MM-dd').format(data['timestamp'].toDate())}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 4), // Add spacing between date and time
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 18, color: Colors.red),
                              const SizedBox(
                                  width:
                                      4), // Add spacing between icon and text
                              Text(
                                'Time: ${DateFormat('HH:mm').format(data['timestamp'].toDate())}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    )),
          );
        },
      ),
    );
  }
}
