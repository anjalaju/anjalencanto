import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:main_project/chat/chatmain.dart';
import 'package:main_project/chat/chatpage.dart';
import 'package:main_project/chat/profilemodel.dart';
import 'package:main_project/model/feedback_Review.dart';

import 'package:main_project/model/likepostmodel.dart';
import 'package:main_project/view/USER/booking/booking.dart';
import 'package:main_project/view/USER/catogories2/venues/view_reviews.dart';

import 'package:main_project/view/USER/chat.dart';

import 'package:main_project/model/addProject.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Biriyani extends StatefulWidget {
  const Biriyani({super.key});

  @override
  State<Biriyani> createState() => _BiriyaniState();
}

class _BiriyaniState extends State<Biriyani> {
  final formkey = GlobalKey<FormState>();
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
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: Helper.h(context) * .020,
                      ),
                      const Row(
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
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
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
                        decoration: const InputDecoration(
                            hintText: 'ADD FEEDBACK',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                        },
                      ),
                      SizedBox(
                        height: Helper.h(context) * .020,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                if (provider.rating != null) {
                                  provider.addReviewFeedback(
                                      FeedbackReview(
                                          productid: model.id.toString(),
                                          feedback: feedbackcon.text,
                                          feedbackcount:
                                              provider.rating.toString(),
                                          useruid: auth.currentUser!.uid,
                                          timestamp: Timestamp.now()),
                                      model.id);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Success')));
                                  provider.claerrat();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'please select the rating')));
                                }

                                log('the review working  ${provider.rating}');
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Helper.h(context) * .050,
                              width: Helper.W(context) * .30,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: const Text('ADD REVIEW'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
            'Biriyani Dishes',
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
      body: Column(
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
              hintText: ("  Search event name ..."),
              prefixIcon: const Icon(Icons.search),
            ),
            onTap: () {
              provider.allsearch(
                  eventmaincategory:'Catering',
                  eventsubcategory: 'Biriyani Dishes');

              log(provider.banqustall.length.toString());
            },
            onChanged: (value) {
              provider.searcheventbycategory(value);
            },
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<FunctionProvider>(
                  builder: (context, helper, child) {
                    return StreamBuilder(
                      stream:
                          helper.getEventprojectuser('Catering', 'Biriyani Dishes'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                       

                        List<EventModel> list = [];
                        list = snapshot.data!.docs.map((e) {
                          return EventModel.fromJsone(
                              e.data() as Map<String, dynamic>);
                        }).toList();

                        final searchall = provider.banqustall.isEmpty 
                        ? list
                        : provider.searchall;


                        if(searchall.isEmpty){
                          return const Text('NO SEARCH EVENT FOUND');
                        }


                        if (snapshot.hasData) {
                          return list.isEmpty
                              ? const Center(
                                  child: Text('no event '),
                                )
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: searchall.length,
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
                                                searchall[index].Image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
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
                                                    Text('EVENT NAME:${searchall[index].eventName}'),
                                                    // IconButton(
                                                    //     onPressed: () {
                                                    //       Navigator.of(context).push(MaterialPageRoute(
                                                    //         builder: (context) => Shortsearchall(),
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
                                                                  searchall[index]
                                                                      .id
                                                                      .toString()),
                                                          builder: (context,
                                                              snapshot) {
                                                            return IconButton(
                                                              onPressed: () {
                                                                helper.likepost(
                                                                  Likepostmodel(
                                                                    postid: searchall[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    likeid:
                                                                        searchall[index]
                                                                            .id,
                                                                    likeuid: auth
                                                                        .currentUser!
                                                                        .uid,
                                                                  ),
                                                                  auth.currentUser!
                                                                          .uid +
                                                                      searchall[index]
                                                                          .id
                                                                          .toString(),
                                                                );
                                                              },
                                                              icon: Icon(
                                                                helper.islike ==
                                                                        true
                                                                    ? Icons
                                                                        .favorite
                                                                    : Icons
                                                                        .favorite_border,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                                Text('EVENT PLACE ${searchall[index].eventPlace}'),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(searchall[index]
                                                        .discription),
                                                    OutlinedButton(
                                                        style: ButtonStyle(
                                                            foregroundColor:
                                                                MaterialStateProperty.all(
                                                                    const Color(
                                                                        0xff496FF7)),
                                                            textStyle: MaterialStateProperty.all(
                                                                const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14)),
                                                            minimumSize:
                                                                MaterialStateProperty.all(
                                                                    const Size(
                                                                        200,
                                                                        50)),
                                                            side: MaterialStateProperty.all(
                                                                const BorderSide(color: Color(0xff496FF7))),
                                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Bookimgpage(
                                                                            eventModel:
                                                                                searchall[index],
                                                                          )));
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
                                                    const Icon(
                                                      Icons.currency_rupee,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      searchall[index]
                                                          .startingPriceFrom,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    //  Text(
                                                    //   list[index].uid,

                                                    // ),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                    style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty.all(
                                                                const Color(
                                                                    0xffFF004D)),
                                                        textStyle: MaterialStateProperty.all(
                                                            const TextStyle(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 14)),
                                                        minimumSize:
                                                            MaterialStateProperty.all(
                                                                const Size(
                                                                    250, 50)),
                                                        side: MaterialStateProperty.all(
                                                            const BorderSide(
                                                                color: Color(0xffFF004D))),
                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                                                    onPressed: () {
                                                      final entruid =
                                                          list[index]
                                                              .enterprenurid;
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatPage(
                                                          reciveerID: entruid,
                                                          reciveeremail: '',
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
                                                    ),),
                                                OutlinedButton(
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all(const Color(
                                                                0xff63C336)),
                                                    textStyle:
                                                        MaterialStateProperty
                                                            .all(
                                                      const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                30, 50)),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      const CircleBorder(),
                                                    ),
                                                    side: MaterialStateProperty
                                                        .all(
                                                      const BorderSide(
                                                          color: Color(
                                                              0xff63C336)),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    _makePhoneCall(
                                                        list[index].phonenumber);
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
                                                  width:
                                                      Helper.W(context) * .40,
                                                  height:
                                                      Helper.h(context) * .050,
                                                  // color: Colors.red,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                  ),
                                                  child: const Text(
                                                    'ADD REVIEW ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewRevies(
                                                    documentId:
                                                        '${list[index].id}',
                                                  ),
                                                ));
                                                ;
                                              },
                                              child: const Text('View Revies'))
                                          // Consumer<FunctionProvider>(
                                          //   builder: (context, heper, child) {
                                          //     return StreamBuilder(
                                          //       stream: helper
                                          //           .getReviewuser(list[index].id),
                                          //       builder: (context, snapshot) {
                                          //         if (snapshot.connectionState ==
                                          //             ConnectionState.waiting) {
                                          //           return CircularProgressIndicator();
                                          //         }

                                          //         if (!snapshot.hasData ||
                                          //             snapshot.data!.docs.isEmpty) {
                                          //           return Center(
                                          //               child: Text(
                                          //                   'No reviews available'));
                                          //         }

                                          //         List<FeedbackReview> reviewlist =
                                          //             [];

                                          //         reviewlist =
                                          //             snapshot.data!.docs.map((e) {
                                          //           return FeedbackReview.fromjsone(
                                          //               e.data() as Map<String,
                                          //                   dynamic>);
                                          //         }).toList();

                                          //         final uid =
                                          //             reviewlist[index].useruid;

                                          //         Stream userdet = db
                                          //             .collection('firebase')
                                          //             .doc(uid)
                                          //             .snapshots();

                                          //         return reviewlist.isEmpty
                                          //             ? Center(
                                          //                 child: Text(''),
                                          //               )
                                          //             : ListView.separated(
                                          //                 shrinkWrap: true,
                                          //                 physics:
                                          //                     BouncingScrollPhysics(),
                                          //                 itemCount:
                                          //                     reviewlist.length,
                                          //                 itemBuilder:
                                          //                     (context, index) {
                                          //                   return Padding(
                                          //                     padding: EdgeInsets
                                          //                         .symmetric(
                                          //                       horizontal: Helper.W(
                                          //                               context) *
                                          //                           .030,
                                          //                     ),
                                          //                     child: Column(
                                          //                       children: [
                                          //                         Text(reviewlist[
                                          //                                 index]
                                          //                             .feedback),
                                          //                         StreamBuilder(
                                          //                           stream: userdet,
                                          //                           builder: (context,
                                          //                               snapshot) {
                                          //                             if (snapshot
                                          //                                     .connectionState ==
                                          //                                 ConnectionState
                                          //                                     .waiting) {
                                          //                               return CircularProgressIndicator();
                                          //                             }
                                          //                             return Text(
                                          //                                 'USERNAME : ${snapshot.data['User_Name']}');
                                          //                           },
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   );
                                          //                 },
                                          //                 separatorBuilder:
                                          //                     (context, index) {
                                          //                   return SizedBox(
                                          //                     height: Helper.W(
                                          //                             context) *
                                          //                         .030,
                                          //                   );
                                          //                 },
                                          //               );
                                          //       },
                                          //     );
                                          //   },
                                          // )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
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
          ))
        ],
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