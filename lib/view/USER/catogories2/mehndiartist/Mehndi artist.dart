import 'dart:async';
import 'dart:developer';

import 'package:animated_rating_stars/animated_rating_stars.dart';
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
import 'package:rating_summary/rating_summary.dart';
import 'package:url_launcher/url_launcher.dart';

class Mehndiartistt extends StatefulWidget {
  const Mehndiartistt({super.key});

  @override
  State<Mehndiartistt> createState() => _MehndiartisttState();
}

class _MehndiartisttState extends State<Mehndiartistt> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionProvider>(context);

    final feedbackcon = TextEditingController();

    // Future bottomSheet(EventModel model) async {
    //   showModalBottomSheet<void>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Container(
    //         height: Helper.h(context) / 2,
    //         color: Colors.grey,
    //         child: Center(
    //           child: Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: Helper.W(context) * .010,
    //             ),
    //             child: Form(
    //               key: formkey,
    //               child: Column(
    //                 children: <Widget>[
    //                   SizedBox(
    //                     height: Helper.h(context) * .020,
    //                   ),
    //                   const Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Text('PRODUCT REVIEW AND FEED BACK'),
    //                     ],
    //                   ),
    //                   Consumer<FunctionProvider>(
    //                     builder: (context, helper, child) {
    //                       return RatingBar.builder(
    //                         itemSize: 25,
    //                         initialRating: 0,
    //                         minRating: 1,
    //                         direction: Axis.horizontal,
    //                         allowHalfRating: true,
    //                         itemCount: 5,
    //                         itemPadding:
    //                             const EdgeInsets.symmetric(horizontal: 4.0),
    //                         itemBuilder: (context, _) => const Icon(
    //                           Icons.star,
    //                           color: Colors.amber,
    //                         ),
    //                         onRatingUpdate: (rating) {
    //                           setState(() {
    //                             provider.rating = rating.toString();
    //                           });
    //                         },
    //                       );
    //                     },
    //                   ),
    //                   SizedBox(
    //                     height: Helper.h(context) * .020,
    //                   ),
    //                   TextFormField(
    //                     controller: feedbackcon,
    //                     decoration: const InputDecoration(
    //                         hintText: 'ADD FEEDBACK',
    //                         border: OutlineInputBorder()),
    //                     validator: (value) {
    //                       if (value!.isEmpty) {
    //                         return 'required';
    //                       }
    //                     },
    //                   ),
    //                   SizedBox(
    //                     height: Helper.h(context) * .020,
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       GestureDetector(
    //                         onTap: () {
    //                           if (formkey.currentState!.validate()) {
    //                             if (provider.rating != null) {
    //                               provider.addReviewFeedback(
    //                                   FeedbackReview(
    //                                       productid: model.id.toString(),
    //                                       feedback: feedbackcon.text,
    //                                       feedbackcount:
    //                                           provider.rating.toString(),
    //                                       useruid: auth.currentUser!.uid,
    //                                       timestamp: Timestamp.now()),
    //                                   model.id);
    //                               Navigator.pop(context);
    //                               ScaffoldMessenger.of(context).showSnackBar(
    //                                   const SnackBar(content: Text('Success')));
    //                               provider.claerrat();
    //                             } else {
    //                               ScaffoldMessenger.of(context).showSnackBar(
    //                                   const SnackBar(
    //                                       content: Text(
    //                                           'please select the rating')));
    //                             }

    //                             log('the review working  ${provider.rating}');
    //                           }
    //                         },
    //                         child: Container(
    //                           alignment: Alignment.center,
    //                           height: Helper.h(context) * .050,
    //                           width: Helper.W(context) * .30,
    //                           decoration: BoxDecoration(
    //                             border: Border.all(),
    //                           ),
    //                           child: const Text('ADD REVIEW'),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }
    Future editbootmsheet(EventModel model) async {
      await showModalBottomSheet<void>(
        context: context, backgroundColor: Colors.white,
        isScrollControlled:
            true, // Allows the bottom sheet to take full screen height when dragged
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.6,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: feedbackcon,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'ADD FEEDBACK',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Feedback is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('AddEvent')
                          .doc(model.id.toString())
                          .collection('FeedbackReview')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        List<QueryDocumentSnapshot> reviews =
                            snapshot.data!.docs;

                        int totalRatings = reviews.length;
                        double averageRating = 0;
                        int counterFiveStars = 0;
                        int counterFourStars = 0;
                        int counterThreeStars = 0;
                        int counterTwoStars = 0;
                        int counterOneStars = 0;

                        if (totalRatings > 0) {
                          for (var review in reviews) {
                            double rating =
                                double.tryParse(review['Feedbackcount']) ?? 0;
                            averageRating += rating;

                            if (rating == 5)
                              counterFiveStars++;
                            else if (rating == 4)
                              counterFourStars++;
                            else if (rating == 3)
                              counterThreeStars++;
                            else if (rating == 2)
                              counterTwoStars++;
                            else if (rating == 1) counterOneStars++;
                          }

                          averageRating /= totalRatings;
                        }

                        double _rating =
                            0; // Initialize the user's rating input

                        return Container(
                          color: Colors.white,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Form(
                                key: formkey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 20.0),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          AnimatedRatingStars(
                                            initialRating: 0,
                                            onChanged: (rating) {
                                              setState(() {
                                                _rating = rating;
                                              });
                                            },
                                            displayRatingValue: true,
                                            interactiveTooltips: true,
                                            customFilledIcon: Icons.star,
                                            customHalfFilledIcon:
                                                Icons.star_half,
                                            customEmptyIcon: Icons.star_border,
                                            starSize: 40.0,
                                            animationDuration: const Duration(
                                                milliseconds: 500),
                                            animationCurve: Curves.easeInOut,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    GestureDetector(
                                      onTap: () {
                                        if (formkey.currentState!.validate()) {
                                          if (_rating > 0) {
                                            provider.addReviewFeedback(
                                              FeedbackReview(
                                                productid: model.id.toString(),
                                                feedback: feedbackcon.text,
                                                feedbackcount:
                                                    _rating.toString(),
                                                useruid: auth.currentUser!.uid,
                                                timestamp: Timestamp.now(),
                                              ),
                                              model.id,
                                            );
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text('Success')),
                                            );
                                            provider.claerrat();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Please select the rating'),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(),
                                        ),
                                        child: const Text(
                                          'ADD REVIEW',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: RatingSummary(
                                        counter: totalRatings,
                                        average: averageRating,
                                        counterFiveStars: counterFiveStars,
                                        counterFourStars: counterFourStars,
                                        counterThreeStars: counterThreeStars,
                                        counterTwoStars: counterTwoStars,
                                        counterOneStars: counterOneStars,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mehndi artist',
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
                  eventmaincategory: 'Mehandi artist',
                  eventsubcategory: 'Mehandhi artist');

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
                      stream: helper.getEventprojectuser(
                          'Mehandi artist', 'Mehandhi artist'),
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

                        // if (searchall.isEmpty) {
                        //   return const Text('NO SEARCH EVENT FOUND');
                        // }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child:
                                Center(child: Image.asset('images/event.jpeg')),
                          );
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
                                          SizedBox(
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
                                                    Text(
                                                        'EVENT NAME : ${searchall[index].eventName}'),
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
                                                                  searchall[
                                                                          index]
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
                                                                      searchall[
                                                                              index]
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
                                                Text(
                                                    'EVENT PLACE : ${searchall[index].eventPlace}'),
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
                                                      textStyle:
                                                          MaterialStateProperty.all(
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14)),
                                                      minimumSize: MaterialStateProperty.all(
                                                          const Size(250, 50)),
                                                      side: MaterialStateProperty.all(
                                                          const BorderSide(
                                                              color:
                                                                  Color(0xffFF004D))),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                                                  onPressed: () {
                                                    final entruid = list[index]
                                                        .enterprenurid;
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
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
                                                  ),
                                                ),
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
                                                    _makePhoneCall(list[index]
                                                        .phonenumber);
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
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      backgroundColor:
                                                          Colors.blueGrey,
                                                      foregroundColor:
                                                          Colors.white),
                                                  onPressed: () {
                                                    // bottomSheet(
                                                    //     list[index], context);
                                                    editbootmsheet(list[index]);
                                                  },
                                                  child:
                                                      const Text('Add Review')),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      backgroundColor:
                                                          Colors.indigo,
                                                      foregroundColor:
                                                          Colors.white),
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
                                                  child:
                                                      const Text('View Review'))
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 1.5,
                                      color: Colors.black,
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