import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/model/userbookingmodel.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class BookEventScren extends StatelessWidget {
  const BookEventScren({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> _showMyDialog(  id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ARE YOU SURE CONFORM YOUR EVENT CLOSE'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CLOSE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
           Consumer<FunctionProvider>(builder: (context, helper, child) {
             return TextButton(
            child: const Text('Approve'),
            onPressed: () {
              helper.deleteBooking(id);

              Navigator.of(context).pop();
            },
          );
           },)
        ],
      );
    },
  );
}
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking list',
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
        child: Column(
          children: [
            Consumer<FunctionProvider>(
              builder: (context, instance, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: instance.getBookingevent(auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<BookingModle> list = [];

                    list = snapshot.data!.docs.map((e) {
                      return BookingModle.fromjsone(
                          e.data() as Map<String, dynamic>);
                    }).toList();

                    if (snapshot.hasData) {
                      return list.isEmpty
                          ? const Center(
                              child: Text('No booking'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final doc = list[index].eventid;

                                final data = db
                                    .collection('AddEvent')
                                    .doc(doc)
                                    .snapshots();

                                return Container(
                                  width: 200,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              StreamBuilder(
                                                stream: data,
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          snapshot
                                                              .data!['image'],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                      'PAYMNET STATUS :${list[index].paymentstatus}'),
                                                  Text(
                                                      'BOOKING DATE :${list[index].date}'),
                                                  Text(
                                                      'EVENT PRICE :${list[index].eventprice}'),
                                                ],
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () async{
                                               await _showMyDialog(list[index].id);
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 50,
                                );
                              },
                            );
                    }
                    return Container();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
