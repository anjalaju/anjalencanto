import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRatingAndReview extends StatefulWidget {
  AdminRatingAndReview({super.key});

  @override
  State<AdminRatingAndReview> createState() => _AdminRatingAndReviewState();
}

class _AdminRatingAndReviewState extends State<AdminRatingAndReview> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<DocumentSnapshot>> getAllReviews() async {
  QuerySnapshot addEventSnapshot = await db.collection('AddEvent').get();

  List<DocumentSnapshot> allReviews = [];
  for (var doc in addEventSnapshot.docs) {
    QuerySnapshot feedbackReviewSnapshot = await doc.reference
        .collection('FeedbackReview')
        .orderBy('timestamp', descending: true)
        .get();
    allReviews.addAll(feedbackReviewSnapshot.docs);
  }

  // Sort allReviews by timestamp after combining them (if required)
  allReviews.sort((a, b) {
    Timestamp timestampA = a['timestamp'] ?? Timestamp.now();
    Timestamp timestampB = b['timestamp'] ?? Timestamp.now();
    return timestampB.compareTo(timestampA); // Sort in descending order
  });

  return allReviews;
}


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
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getAllReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final reviews = snapshot.data ?? [];

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];

              final reviewText = review['FeedBack'] ?? 'No Feedback';
              final feedbackCount = review['Feedbackcount'] ?? '0';
               final uid = review['userid'] ?? '';

              int feedback;
              try {
                feedback = int.parse(feedbackCount);
              } catch (e) {
                try {
                  feedback = double.parse(feedbackCount).toInt();
                } catch (e) {
                  feedback = 0;
                }
              }

              Timestamp timestamp = review['timestamp'] ?? Timestamp.now();
              DateTime reviewDateTime = timestamp.toDate();
              String formattedDate = DateFormat('MMM d, yyyy').format(reviewDateTime);
              String formattedTime = DateFormat.jm().format(reviewDateTime);

              return ReviewItem(
                review: reviewText,
                uid: uid,
                docid: review.id,
                count: feedbackCount,
                feedback: feedback,
                formattedDate: formattedDate,
                formattedTime: formattedTime,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          );
        },
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String review;
  final String uid;
  final String docid;
  final String count;
  final int feedback;
  final String formattedDate;
  final String formattedTime;

  ReviewItem({
    required this.review,
    required this.uid,
    required this.docid,
    required this.count,
    required this.feedback,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String id = _auth.currentUser!.uid;
    final db = FirebaseFirestore.instance;

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
                  review,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                FutureBuilder<DocumentSnapshot>(
                  future: db.collection('firebase').doc(uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('');
                    }

                    final userName = snapshot.data!['User_Name'] ?? 'Unknown';

                    return Text(
                      'Username: $userName',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                Text(formattedTime),
                Text(formattedDate),
                ReviewFeedbackIcons(feedbackCount: feedback.toDouble()),
                Text(count),
              ],
            ),
            Visibility(
              visible: id == uid,
              child: InkWell(
                onTap: () async {
                  final functionProvider = Provider.of<FunctionProvider>(context, listen: false);
                  await functionProvider.deleteReview(docid, review);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 35,
                  width: 35,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewFeedbackIcons extends StatelessWidget {
  final double feedbackCount;

  ReviewFeedbackIcons({required this.feedbackCount});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      RatingBar.builder(
        itemSize: 25,
        initialRating: feedbackCount,
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
      ),
    ]);
  }
}
