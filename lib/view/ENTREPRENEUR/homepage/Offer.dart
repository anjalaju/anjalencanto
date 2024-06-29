import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/offerpageb.dart';

class Entreofferpage extends StatefulWidget {
  const Entreofferpage({super.key});

  @override
  State<Entreofferpage> createState() => _EntreofferpageState();
}

class _EntreofferpageState extends State<Entreofferpage> {
  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollingFabAnimated(
        color: Colors.indigo,
        width: 140,
        height: 50,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
        text: const Text(
          'Add Your Offer',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
        onPress: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Enofferpagee(),
          ));
        },
        scrollController: _scrollController,
        animateIcon: true,
        inverted: false,
        radius: 10.0,
      ),
      appBar: AppBar(
        title: const Text(
          'Offer',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          
        ),
        // actions: [
        //   Text(auth.currentUser!.uid)
        // ],
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Offer')  
                      // .where('uid', isEqualTo: auth.currentUser!.uid)
                      .orderBy('timestamp',
                          descending: true)  
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Image.asset('images/no offer.avif'));
                    }
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];
                            return Dismissible(
                                key: Key(data.id.toString()),
                                direction: DismissDirection
                                    .endToStart, // Specify the direction to dismiss (e.g., horizontal, vertical, etc.)
                                onDismissed: (direction) {
                                  // Handle what happens after dismissal (e.g., remove item from list)
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection('Offer')
                                        .doc(data.id)
                                        .delete()
                                        .then((value) =>
                                            print('Document deleted'))
                                        .catchError((error) => print(
                                            'Failed to delete document: $error'));
                                  });
                                },
                                background: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.red,
                                  ),
                                  child: Icon(Icons.delete),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(left: 20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      12), // Optional: adds rounded corners
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          12), // Optional: adds rounded corners
                                    ),
                                    child: Image.network(
                                      '${data['Image']}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ));
                          },
                          itemCount: snapshot.data!.docs.length,
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: OutlinedButton(
              //       style: ButtonStyle(
              //           foregroundColor:
              //               MaterialStateProperty.all(const Color(0xff496FF7)),
              //           textStyle: MaterialStateProperty.all(const TextStyle(
              //               fontWeight: FontWeight.w600, fontSize: 14)),
              //           // minimumSize:
              //           //     MaterialStateProperty.all(const Size(100, 30)),
              //           maximumSize:
              //               MaterialStateProperty.all(const Size(200, 80)),
              //           side: MaterialStateProperty.all(
              //               const BorderSide(color: Color(0xff496FF7))),
              //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30)))),
              //       onPressed: () {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => const Enofferpagee(),
              //         ));
              //       },
              //       child: const Row(
              //         children: [
              //           Text("Add your offer"),
              //           SizedBox(
              //             width: 20,
              //           ),
              //           Icon(Icons.add),
              //         ],
              //       )),
              // )
            ],
          )),
    );
  }
}
