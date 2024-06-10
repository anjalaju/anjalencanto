import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text(
          'Search',
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
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //   ),
        //   color: Colors.black,
        // ),
        // actions: [
        //   IconButton(onPressed: () {
        //                   Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => const Shortlist()));
        //   }, icon: const Icon(Icons.favorite)),
        //   IconButton(onPressed: () {
        //      Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => Chatpage(),
        //         ));
        //   }, icon: const Icon(Icons.chat_outlined))
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: ("Search by location"),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Icon(Icons.location_on)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
