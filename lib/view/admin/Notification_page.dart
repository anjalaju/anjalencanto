// import 'package:flutter/material.dart';
// import 'package:main_project/controller/FunctionProvider.dart';
// import 'package:main_project/utils/String.dart';
// import 'package:provider/provider.dart';

// class NotificationPgae extends StatefulWidget {
//   const NotificationPgae({super.key});

//   @override
//   State<NotificationPgae> createState() => _NotificationPgaeState();
// }

// class _NotificationPgaeState extends State<NotificationPgae> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               width: Helper.W(context) / 1,
//               height: Helper.h(context) * .250,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: Helper.h(context) * .050,
//                   ),
//                   Consumer<FunctionProvider>(
//                     builder: (context, helper, child) {
//                       return StreamBuilder(
//                         stream: helper.getNotificationall().asStream(),
//                         builder: (context, snapshot) {
//                           final noti = helper.allnoti;
//                           return noti.isEmpty? Center(child: Text('NO Notifications !'),):ListView.separated(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Helper.W(context) * .050),
//                             shrinkWrap: true,
//                             controller: ScrollController(),
//                             physics: BouncingScrollPhysics(),
//                             itemCount: noti.length,
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
//                                                 'NOTIFICATION TITLE :${noti[index].notificationtitile}'),
//                                             Text(
//                                                 'NOTIFICATION SUBTITLE ${noti[index].notificationSubtitile}'),
//                                           ],
//                                         ),
//                                         IconButton(
//                                             onPressed: () {
//                                               db.collection('Notiication').doc(noti[index].id).delete();
//                                               setState(() {

//                                               });
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPgae extends StatefulWidget {
  @override
  _NotificationPgaeState createState() => _NotificationPgaeState();
}

class _NotificationPgaeState extends State<NotificationPgae> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = _firestore.collection('Notiication').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: const Color(0xffE72245),
          title: const Text(
            'Notifications',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = documents[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.indigo,
                      title: Text(
                        "Notification Title :${data['Notificationtitle']}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notification Subtitle :${data['Notificationsubtitle']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                            Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.calendar_today,
                                                        size: 18,
                                                        color: Colors.red),
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
                                                    height:
                                                        4), // Add spacing between date and time
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.access_time,
                                                        size: 18,
                                                        color: Colors.red),
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
                      trailing: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.red,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _deleteNotification(document.id),
                        ),
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

  void _deleteNotification(String documentId) {
    _firestore.collection('Notiication').doc(documentId).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification deleted')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete notification: $error')),
      );
    });
  }
}
