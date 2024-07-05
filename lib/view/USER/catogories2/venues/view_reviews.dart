import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/feedback_Review.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewRevies extends StatelessWidget {
  final String documentId;

  ViewRevies({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: const Text(
          'Reviews',
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
      body: Consumer<FunctionProvider>(
        builder: (context, helper, child) {
          return StreamBuilder(
            stream: helper.getReviewuser(documentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No reviews available'));
              }

              List<FeedbackReview> reviewList = snapshot.data!.docs.map((e) {
                return FeedbackReview.fromjsone(
                    e.data() as Map<String, dynamic>);
              }).toList();

              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: reviewList.length,
                itemBuilder: (context, index) {
                  final review = reviewList[index];
                  final uid = review.useruid;

                  int feedback;
                  try {
                    feedback = int.parse(review.feedbackcount);
                  } catch (e) {
                    try {
                      feedback = double.parse(review.feedbackcount).toInt();
                    } catch (e) {
                      feedback = 0;
                    }
                  }

                  return Column(
                    children: [
                      ReviewItem(
                        review: review,
                        uid: uid,
                        docid: documentId,
                        count: review.feedbackcount,
                        feedback: feedback,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
              );
            },
          );
        },
      ),
    );
  }
}

class ReviewFeedbackIcons extends StatelessWidget {
  final double feedbackCount;

  ReviewFeedbackIcons({required this.feedbackCount});

  @override
  Widget build(BuildContext context) {
    double value = feedbackCount;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      RatingBar.builder(
        itemSize: 25,
        initialRating: value,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {},
      )
    ]);
  }
}

class ReviewItem extends StatelessWidget {
  final FeedbackReview review;
  final String uid;
  final String docid;
  final String count;
  final int feedback;

  ReviewItem(
      {required this.review,
      required this.uid,
      required this.docid,
      required this.count,
      required this.feedback});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    String id = _auth.currentUser!.uid;
    final db = FirebaseFirestore.instance;
    print('======${docid}');
    DateTime reviewDateTime = review.timestamp.toDate();

    // Format date (e.g., Jan 1, 2023)
    String formattedDate = DateFormat('MMM d, yyyy').format(reviewDateTime);

    // Format time (e.g., 12:00 PM)
    String formattedTime = DateFormat.jm().format(reviewDateTime);
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.feedback,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                StreamBuilder<DocumentSnapshot>(
                  stream: db.collection('firebase').doc(uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('User details not available');
                    }

                    final userName = snapshot.data!['User_Name'] ?? 'Unknown';

                    final count = review.feedbackcount;

                    return Text(
                      'Username: $userName',
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey,),
                    );
                  },
                ),
                Text(formattedTime),
                Text(formattedDate),
                ReviewFeedbackIcons(
                  feedbackCount: feedback.toDouble(),
                ),
                Text(count),
              ],
            ),
            Visibility(
              visible: id == uid,
              child: InkWell(
                onTap: () async {
                  final functionProvider =
                      Provider.of<FunctionProvider>(context, listen: false);
                  await functionProvider.deleteReview(
                      docid, review.id.toString());
                  print('=======${review.id.toString()}');
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    height: 35,
                    width: 35,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget viewFeedback(String count) {
  int starCount = int.tryParse(count) ?? 0;

  // Ensure starCount is within the valid range of 0 to 5
  starCount = starCount.clamp(0, 5);

  return Row(
    children: List.generate(starCount, (index) => Icon(Icons.star)),
  );
}


//    viewfeedback(String count) {
//   switch (count) {
//     case '1':
//       return Row(
//         children: [
//           Icon(Icons.star),
//         ],
//       );
//     case '2':
//       return Row(
//         children: [
//           Icon(Icons.star),
//           Icon(Icons.star),
//         ],
//       );
//     case '3':
//       return Row(
//         children: [
//           Icon(Icons.star),
//           Icon(Icons.star),
//           Icon(Icons.star),
//         ],
//       );
//     case '4':
//       return Row(
//         children: [
//           Icon(Icons.star),
//           Icon(Icons.star),
//           Icon(Icons.star),
//           Icon(Icons.star),
//         ],
//       );
//     case '5':
//       return Row(
//         children: [
//           Icon(Icons.star),
//           Icon(Icons.star),
//           Icon(Icons.star),
//           Icon(Icons.star),
//           Icon(Icons.star),
//         ],
//       );
//   }
// }
