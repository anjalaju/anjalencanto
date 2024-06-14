import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:main_project/chat/chatmain.dart';
import 'package:main_project/chat/profilemodel.dart';
import 'package:main_project/model/feedback_Review.dart';

import 'package:main_project/model/likepostmodel.dart';
import 'package:main_project/view/USER/booking/booking.dart';

import 'package:main_project/view/USER/chat.dart';

import 'package:main_project/model/addProject.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Bankquethall extends StatefulWidget {
  const Bankquethall({super.key});

  @override
  State<Bankquethall> createState() => _BankquethallState();
}

class _BankquethallState extends State<Bankquethall> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionProvider>(context);

    final feedbackcon = TextEditingController();

    Future bottomSheet(EventModel model) async {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: Helper.h(context) / 2,
            color: Colors.grey,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Helper.W(context) * .010,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: Helper.h(context) * .020,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('PRODUCT REVIEW AND FEED BACK'),
                      ],
                    ),
                    Consumer<FunctionProvider>(
                      builder: (context, helper, child) {
                        return RatingBar.builder(
                          itemSize: 25,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              provider.rating = rating.toString();
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: Helper.h(context) * .020,
                    ),
                    TextFormField(
                      controller: feedbackcon,
                      decoration: InputDecoration(
                          hintText: 'ADD FEEDBACK',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: Helper.h(context) * .020,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (provider.rating != null) {
                              provider.addReviewFeedback(
                                  FeedbackReview(
                                    productid: model.id.toString(),
                                    feedback: feedbackcon.text,
                                    feedbackcount: provider.rating.toString(),
                                    useruid: auth.currentUser!.uid,
                                  ),
                                  model.id);
                              Navigator.pop(context);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('PLEASE SEECT FEED RATING')));

                            log('the review working  ${provider.rating}');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: Helper.h(context) * .050,
                            width: Helper.W(context) * .30,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Text('ADD REVIEW'),
                          ),
                        ),
                      ],
                    ),
                    Text(model.id.toString())
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Banquet Halls',
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
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: const Color(0xffD9D9D9),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: ("  Search Venues..."),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            Consumer<FunctionProvider>(
              builder: (context, helper, child) {
                return StreamBuilder(
                  stream: helper.getEventproject('Venues', 'Banquet halls'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<EventModel> list = [];
                    list = snapshot.data!.docs.map((e) {
                      return EventModel.fromJsone(
                          e.data() as Map<String, dynamic>);
                    }).toList();

                    if (snapshot.hasData) {
                      return list.isEmpty
                          ? Center(
                              child: Text('no event'),
                            )
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        height: 231,
                                        width: 350,
                                        child: Image(
                                          image: NetworkImage(
                                            list[index].Image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(list[index].eventName),
                                                // IconButton(
                                                //     onPressed: () {
                                                //       Navigator.of(context).push(MaterialPageRoute(
                                                //         builder: (context) => Shortlist(),
                                                //       ));
                                                //     },
                                                //     icon: const Icon(Icons.favorite_border)
                                                //     )
                                                // LikeButton(
                                                //   likeBuilder: (bool isLiked) {
                                                //     return Icon(
                                                //       isLiked
                                                //           ? Icons.favorite
                                                //           : Icons.favorite_border,
                                                //       color: isLiked
                                                //           ? Colors.red
                                                //           : Colors.grey,
                                                //       size: 30,
                                                //     );
                                                //   },

                                                // ),
                                                Consumer<FunctionProvider>(
                                                  builder: (context,
                                                      valuhelpere, child) {
                                                    return FutureBuilder(
                                                      future: helper
                                                          .fetchlikedpostpost(auth
                                                                  .currentUser!
                                                                  .uid +
                                                              list[index]
                                                                  .id
                                                                  .toString()),
                                                      builder:
                                                          (context, snapshot) {
                                                        return IconButton(
                                                          onPressed: () {
                                                            helper.likepost(
                                                              Likepostmodel(
                                                                postid: list[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                likeid:
                                                                    list[index]
                                                                        .id,
                                                                likeuid: auth
                                                                    .currentUser!
                                                                    .uid,
                                                              ),
                                                              auth.currentUser!
                                                                      .uid +
                                                                  list[index]
                                                                      .id
                                                                      .toString(),
                                                            );
                                                          },
                                                          icon: Icon(
                                                            helper.islike ==
                                                                    true
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            color: Colors.red,
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                            Text(list[index].eventPlace),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(list[index].discription),
                                                OutlinedButton(
                                                    style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty.all(
                                                                const Color(
                                                                    0xff496FF7)),
                                                        textStyle: MaterialStateProperty.all(
                                                            const TextStyle(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 14)),
                                                        minimumSize:
                                                            MaterialStateProperty.all(
                                                                const Size(
                                                                    200, 50)),
                                                        side: MaterialStateProperty.all(
                                                            const BorderSide(
                                                                color: Color(0xff496FF7))),
                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            Bookimgpage(eventModel: list[index],)
                                                      ));
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.message),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text("Book now"),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  size: 20,
                                                ),
                                                Text(
                                                  list[index].startingPriceFrom,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OutlinedButton(
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty.all(
                                                            const Color(
                                                                0xffFF004D)),
                                                    textStyle:
                                                        MaterialStateProperty.all(
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14)),
                                                    minimumSize: MaterialStateProperty.all(
                                                        const Size(250, 50)),
                                                    side: MaterialStateProperty.all(
                                                        const BorderSide(
                                                            color:
                                                                Color(0xffFF004D))),
                                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        Chatpage(
                                                      name: 'Banquet Halls',
                                                    ),
                                                  ));
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.message),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text("Message"),
                                                  ],
                                                )),
                                            OutlinedButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xff63C336)),
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                  const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(30, 50)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  const CircleBorder(),
                                                ),
                                                side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                      color: Color(0xff63C336)),
                                                ),
                                              ),
                                              onPressed: () {
                                                _makePhoneCall('7025053483');
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.call),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Helper.h(context) * .020,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              bottomSheet(list[index]);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: Helper.W(context) * .40,
                                              height: Helper.h(context) * .050,
                                              // color: Colors.red,
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                              ),
                                              child: Text(
                                                'ADD REVIEW ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Consumer<FunctionProvider>(
                                        builder: (context, heper, child) {
                                          return StreamBuilder(
                                            stream: helper
                                                .getReviewuser(list[index].id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return Center(
                                                    child: Text(
                                                        'No reviews available'));
                                              }

                                              List<FeedbackReview> reviewlist =
                                                  [];

                                              reviewlist =
                                                  snapshot.data!.docs.map((e) {
                                                return FeedbackReview.fromjsone(
                                                    e.data() as Map<String,
                                                        dynamic>);
                                              }).toList();

                                              final uid =
                                                  reviewlist[index].useruid;

                                              Stream userdet = db
                                                  .collection('firebase')
                                                  .doc(uid)
                                                  .snapshots();

                                              return reviewlist.isEmpty
                                                  ? Center(
                                                      child: Text(''),
                                                    )
                                                  : ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount:
                                                          reviewlist.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: Helper.W(
                                                                    context) *
                                                                .030,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Text(reviewlist[
                                                                      index]
                                                                  .feedback),
                                                              StreamBuilder(
                                                                stream: userdet,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return CircularProgressIndicator();
                                                                  }
                                                                  return Text(
                                                                      'USERNAME : ${snapshot.data['User_Name']}');
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          height: Helper.W(
                                                                  context) *
                                                              .030,
                                                        );
                                                      },
                                                    );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Helper.h(context) * .20,
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

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}



//  ChatPage(
//                                                           senderProfileModel:
//                                                               Myprofilemodel(
//                                                                   firstname: list[
//                                                                           index]
//                                                                       .eventName,
//                                                                   email: list[
//                                                                           index]
//                                                                       .eventName,
//                                                                   url: list[
//                                                                           index]
//                                                                       .Image),
//                                                         ),