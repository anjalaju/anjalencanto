import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        title: const Text('Reviews'),
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

                  return ReviewItem(
                    review: review,
                    uid: uid,
                    docid: documentId,
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

class ReviewItem extends StatelessWidget {
  final FeedbackReview review;
  final String uid;
  final String docid;

  ReviewItem({required this.review, required this.uid, required this.docid});

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
                    return Text(
                      'USERNAME: $userName',
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    );
                  },
                ),
                Text(formattedTime),
                Text(formattedDate),
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
