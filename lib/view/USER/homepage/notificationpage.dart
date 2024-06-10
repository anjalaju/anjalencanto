import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/notificationmodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class notificationpage extends StatefulWidget {
  const notificationpage({super.key});

  @override
  State<notificationpage> createState() => _notificationpageState();
}

class _notificationpageState extends State<notificationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Notification',
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
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //   ),
        //   color: Colors.black,
        // ),
        // actions: [
        //   IconButton(onPressed: () {
        //                   Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => const Shortlist()));
        //   }, icon: const Icon(Icons.favorite)),
        //   IconButton(onPressed: () {
        //      Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => Chatpage(),
        //         ));
        //   }, icon: const Icon(Icons.chat_outlined))
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getNotificationall().asStream(),
                    builder: (context, snapshot) {

                      final list=   helper.allnoti;
                      return list.isEmpty
                          ? Center(
                              child: Text('no data'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Material(
                                  color: Colors.grey.shade100,
                                  elevation: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.red
                                        ),
                                    width: double.infinity,
                                    // height: Helper.h(context) * .050,
                                    child: Column(
                                      children: [
                                        
                                        
                                        ListTile(
                                          leading:Text(list[index].notificationtitile),
                                          subtitle:Text(list[index].notificationSubtitile),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Helper.h(context) * .050,
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
      ),
    );
  }
}
