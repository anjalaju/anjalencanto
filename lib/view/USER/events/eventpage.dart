import 'package:flutter/material.dart';

import 'package:main_project/view/USER/events/baby%20shower.dart';
import 'package:main_project/view/USER/events/birthday.dart';
import 'package:main_project/view/USER/events/bridalshower.dart';
import 'package:main_project/view/USER/events/eventlist.dart';
import 'package:main_project/view/USER/events/housewarming.dart';
import 'package:main_project/view/USER/events/mehndinight.dart';
import 'package:main_project/view/USER/events/otherprograms.dart';
import 'package:main_project/view/USER/events/party.dart';
import 'package:main_project/view/USER/events/wedding.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';

class eventpage extends StatefulWidget {
  const eventpage({super.key});

  @override
  State<eventpage> createState() => _eventpageState();
}

TextEditingController _controller = TextEditingController();
List filteredEvents = [];

class _eventpageState extends State<eventpage> {
  @override
  void initState() {
    filteredEvents = eventsList;
    super.initState();
  }

  // elevation: 10,
  void _searchEvents(String enteredval) {
    List results = [];
    if (enteredval.isEmpty) {
      results = eventsList;
    } else {
      results = eventsList
          .where((event) =>
              event["Title"].toLowerCase().contains(enteredval.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredEvents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          'Events',
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
        //  actions: [
        //   IconButton(onPressed: () {
        //                   Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => const Shortlist()));
        //   }, icon: const Icon(Icons.favorite)),
        //   IconButton(onPressed: () {
        //      Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => Chatpage(),
        //         ));
        //   }, icon: const Icon(Icons.chat_outlined))
        // ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                return _searchEvents(value);
              },
              obscureText: false,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 223, 223, 220),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: ("Search your events"),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filteredEvents.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Weddingpage()));
                        break;
                      case 1:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Birthdaypage()));
                        break;
                      case 2:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Housewarmingpage()));
                        break;
                      case 3:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Babyshowerpage()));
                        break;
                      case 4:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Partypage()));
                        break;
                      case 5:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Mehndinightpage()));
                        break;
                      case 6:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Bridalshowerpage()));
                        break;
                      case 7:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Otherprogramspage()));
                        break;
                    }
                  },
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    color: filteredEvents[index]["Color"],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                          ),
                          child: Text(
                            "${filteredEvents[index]["Title"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomLeft: Radius.circular(60)),
                          child: Image.asset(
                            "${filteredEvents[index]["Image"]}",
                            fit: BoxFit.fill,
                            height: 130,
                            width: 160,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: myNav(
        index: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => bottomnavipage(
                      indexnum: 0,
                      
                    )));
          } else if (index == 1) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => bottomnavipage(
                      indexnum: 1,
                    )));
          } else if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => bottomnavipage(
                      indexnum: 2,
                    )));
          } else if (index == 3) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => bottomnavipage(
                      indexnum: 3,
                    )));
          } else if (index == 4) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => bottomnavipage(
                      indexnum: 4,
                    )));
          }
        },
      ),
    );
  }
}
