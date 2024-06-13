import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addreview.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            : ListView.separated(
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  final doc = list[index].uid;

                                  final data = db
                                      .collection('firebase')
                                      .doc(doc)
                                      .snapshots();

                                  return Container(
                                    height: 119,
                                    width: 373,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 199, 194, 179),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            list[index].review,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          StreamBuilder(
                                            stream: data,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              
                                              return Column(
                                                children: [
                                                  // Text(
                                                  //     'Review UserName ${snapshot.data!['User_Name']}'),
                                                  // Text(
                                                  //     'Reviewuser name ${snapshot.data!['Mobile_No']}'),
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
                                  return SizedBox(
                                    height: 30,
                                  );
                                },
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
