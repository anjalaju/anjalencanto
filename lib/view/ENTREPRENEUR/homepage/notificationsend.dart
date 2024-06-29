// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:main_project/controller/FunctionProvider.dart';
// import 'package:main_project/model/notificationmodel.dart';
// import 'package:main_project/utils/String.dart';
// import 'package:provider/provider.dart';

// class Entrenotificationpage extends StatefulWidget {
//   const Entrenotificationpage({super.key});

//   @override
//   State<Entrenotificationpage> createState() => _EntrenotificationpageState();
// }

// class _EntrenotificationpageState extends State<Entrenotificationpage> {
//   final notificationtitile = TextEditingController();
//   final notificationsubtitle = TextEditingController();

//   final formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
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
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//           ),
//           color: Colors.black,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Form(
//             key: formkey,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           height: Helper.h(context) * .20,
//                         ),
//                         SizedBox(
//                           width: Helper.W(context) * .60,
//                           child: TextFormField(
//                             controller: notificationtitile,
//                             decoration: InputDecoration(
//                                 hintText: 'Notification titile',
//                                 border: OutlineInputBorder()),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: Helper.h(context) * .050,
//                         ),
//                         SizedBox(
//                           width: Helper.W(context) * .60,
//                           child: TextFormField(
//                             controller: notificationsubtitle,
//                             decoration: InputDecoration(
//                                 hintText: 'Notification subtitle',
//                                 border: OutlineInputBorder()),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: Helper.h(context) * .040,
//                         ),
//                         Consumer<FunctionProvider>(
//                           builder: (context, helper, child) {
//                             return GestureDetector(
//                               onTap: () {
//                                 if (formkey.currentState!.validate()) {
//                                   helper
//                                       .addNotification(
//                                     NotificationModel(
//                                       notificationtitile:
//                                           notificationtitile.text,
//                                       notificationSubtitile:
//                                           notificationsubtitle.text,
//                                       timestamp: Timestamp.now(),
//                                     ),
//                                   )
//                                       .then((value) {
//                                     SuccesToast(context, 'add notifiction');
//                                     claer();
//                                   });
//                                 }
//                               },
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: Helper.W(context) * .50,
//                                 height: Helper.h(context) * .070,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.grey,
//                                 ),
//                                 child: Text('Add Notification'),
//                               ),
//                             );
//                           },
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   claer() {
//     notificationtitile.clear();
//     notificationsubtitle.clear();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/notificationmodel.dart';
import 'package:main_project/model/usermodel.dart';
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

  String? _selecteduser;

  @override
  Widget build(BuildContext context) {
    final helper = Provider.of<FunctionProvider>(context);
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 85,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Create Notification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(
                  height: Helper.h(context) * .050,
                ),
                StreamBuilder(
                  stream: helper.getusers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    List<Usermodel> userlist = [];

                    userlist = snapshot.data!.docs.map(
                      (e) {
                        return Usermodel.fromJosne(
                            e.data() as Map<String, dynamic>);
                      },
                    ).toList();

                    return DropdownButton(
                      
                      hint: Text('SELECT USER'),
                      items: userlist.map(
                        (e) {
                          return DropdownMenuItem(
                            value: e.Email,
                            child: Text(
                              e.Email,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? value) {
                        _selecteduser = value;
                      },
                    );
                  },
                ),



                SizedBox(
                  height: Helper.h(context) * .050,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: notificationtitile,
                  decoration: InputDecoration(
                    labelText: 'Notification Title',
                    hintText: 'Enter notification title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: notificationsubtitle,
                  decoration: InputDecoration(
                    labelText: 'Notification Subtitle',
                    hintText: 'Enter notification subtitle',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Subtitle is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Consumer<FunctionProvider>(
                  builder: (context, helper, child) {
                    return GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          helper
                              .addNotification(
                            NotificationModel(
                              notificationtitile: notificationtitile.text,
                              notificationSubtitile: notificationsubtitle.text,
                              timestamp: Timestamp.now(),
                              email: _selecteduser.toString()
                            ),
                          )
                              .then((value) {
                            SuccesToast(context, 'Notification added');
                            clear();
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo,
                        ),
                        child: const Text(
                          'Add Notification',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clear() {
    notificationtitile.clear();
    notificationsubtitle.clear();
  }
}
