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
                          ?  const Center(
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
                                          StreamBuilder(
                                            stream: data,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
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
                                                            snapshot.data![
                                                                'image']))),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Text(list[index].email)
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
