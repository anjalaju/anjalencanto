import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Entrecomplaint extends StatefulWidget {
  const Entrecomplaint({super.key});

  @override
  State<Entrecomplaint> createState() => _EntrecomplaintState();
}

class _EntrecomplaintState extends State<Entrecomplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complaints',
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
  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Container(height: MediaQuery.of(context).size.height/1.3,
                        width:MediaQuery.of(context).size.width ,
                          child: Center(
                              child: Image.asset('images/no complaint.jpg')),
                        );
                      }
                      if (snapshot.hasData) {
                        // return list.isEmpty
                        //     ? const Center(
                        //         child: Text('No alert '),
                        //       )
                            // :
                          return   Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListView.separated(controller: ScrollController(),
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
                                        color: Color.fromARGB(255, 185, 228, 183)
                                      ),
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
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        ' Name: ${snapshot.data!['User_Name']}'),
                                                    Text(
                                                        ' Phno: ${snapshot.data!['Mobile_No']}'),
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
