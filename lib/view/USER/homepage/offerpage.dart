import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class offerpage extends StatefulWidget {
  const offerpage({super.key});

  @override
  State<offerpage> createState() => _offerpageState();
}

class _offerpageState extends State<offerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Offers',
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                // stream:
                //     FirebaseFirestore.instance.collection('Offer').snapshots(),
                stream: FirebaseFirestore.instance
                    .collection('Offer')
                    .orderBy('timestamp',
                        descending: true) // Order by timestamp descending
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Image.asset('images/no offer.avif'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            // child: SizedBox(
                            //     height: 200,
                            //     width: 300,
                            //     // color: Colors.amber,
                            //     child: Image.network(
                            //       '${data['Image']}',
                            //       fit: BoxFit.cover,
                            //     )),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              // width: MediaQuery.of(context).size.width,
                              child: AspectRatio(
                                aspectRatio:
                                    16 / 9, // Adjust the aspect ratio as needed
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('${data['Image']}'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        12), // Optional: adds rounded corners
                                  ),
                                ),
                              ),
                            ));
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
