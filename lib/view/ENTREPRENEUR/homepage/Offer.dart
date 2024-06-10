import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/offerpageb.dart';

class Entreofferpage extends StatefulWidget {
  const Entreofferpage({super.key});

  @override
  State<Entreofferpage> createState() => _EntreofferpageState();
}

class _EntreofferpageState extends State<Entreofferpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
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
                                // color: Colors.amber,
                                height: 300,
                                width: 300,
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xff496FF7)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                        // minimumSize:
                        //     MaterialStateProperty.all(const Size(100, 30)),
                            maximumSize:
                            MaterialStateProperty.all(const Size(200, 80)),
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Color(0xff496FF7))),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Enofferpagee(),
                      ));
                    },
                    child: const Row(
                      children: [
                        Text("Add your offer"),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.add),
                      ],
                    )),
              )
            ],
          )),
    );
  }
}
