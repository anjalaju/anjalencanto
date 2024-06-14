import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        body: Column(
      children: [
        Row(
          children: [
            Container(
              width: Helper.W(context) / 1,
              // height: Helper.h(context) * .250,
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          List<AddReview> reviews =
                              snapshot.data!.docs.map((doc) {
                            return AddReview.fromjsone(
                                doc.data() as Map<String, dynamic>);
                          }).toList();

                          return ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: Helper.W(context) * .050),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              return Material(
                                elevation: 4,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                'Review TITLE :${reviews[index].review}'),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              db
                                                  .collection('AddReview')
                                                  .doc(reviews[index].id)
                                                  .delete();
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Helper.h(context) * .020,
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
          ],
        )
      ],
    ));
  }
}
