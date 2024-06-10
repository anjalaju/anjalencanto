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
          'Offer',
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
                stream:
                    FirebaseFirestore.instance.collection('Offer').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                              height: 200,
                              width: 300,
                              // color: Colors.amber,
                              child: Image.network(
                                '${data['Image']}',
                                fit: BoxFit.cover,
                              )),
                        );
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
