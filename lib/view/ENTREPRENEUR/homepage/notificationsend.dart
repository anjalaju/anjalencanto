import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/notificationmodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Entrenotificationpage extends StatefulWidget {
  const Entrenotificationpage({super.key});

  @override
  State<Entrenotificationpage> createState() => _EntrenotificationpageState();
}

class _EntrenotificationpageState extends State<Entrenotificationpage> {
  final notificationtitile = TextEditingController();
  final notificationsubtitle = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: Helper.h(context) * .20,
                        ),
                        SizedBox(
                          width: Helper.W(context) * .60,
                          child: TextFormField(
                            controller: notificationtitile,
                            decoration: InputDecoration(
                                hintText: 'Notification titile',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Helper.h(context) * .050,
                        ),
                        SizedBox(
                          width: Helper.W(context) * .60,
                          child: TextFormField(
                            controller: notificationsubtitle,
                            decoration: InputDecoration(
                                hintText: 'Notification subtitle',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Helper.h(context) * .040,
                        ),
                        Consumer<FunctionProvider>(
                          builder: (context, helper, child) {
                            return GestureDetector(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  helper
                                      .addNotification(
                                    NotificationModel(
                                      notificationtitile:
                                          notificationtitile.text,
                                      notificationSubtitile:
                                          notificationsubtitle.text,
                                      timestamp: Timestamp.now(),
                                    ),
                                  )
                                      .then((value) {
                                    SuccesToast(context, 'add notifiction');
                                    claer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Helper.W(context) * .50,
                                height: Helper.h(context) * .070,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey,
                                ),
                                child: Text('Add Notification'),
                              ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  claer() {
    notificationtitile.clear();
    notificationsubtitle.clear();
  }
}
