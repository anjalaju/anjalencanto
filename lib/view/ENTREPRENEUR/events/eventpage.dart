import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/events/baby%20shower.dart';
import 'package:main_project/view/ENTREPRENEUR/events/birthday.dart';
import 'package:main_project/view/ENTREPRENEUR/events/bridalshower.dart';
import 'package:main_project/view/ENTREPRENEUR/events/eventlist.dart';
import 'package:main_project/view/ENTREPRENEUR/events/housewarming.dart';
import 'package:main_project/view/ENTREPRENEUR/events/mehndinight.dart';
import 'package:main_project/view/ENTREPRENEUR/events/otherprograms.dart';
import 'package:main_project/view/ENTREPRENEUR/events/party.dart';
import 'package:main_project/view/ENTREPRENEUR/events/wedding.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/bottomnav.dart';




class Entreeventpage extends StatefulWidget {
  const Entreeventpage({super.key});

  @override
  State<Entreeventpage> createState() => _EntreeventpageState();
}

TextEditingController _controller = TextEditingController();
List filteredEvents = [];

class _EntreeventpageState extends State<Entreeventpage> {
  @override
  void initState() {
    filteredEvents = entreeventsList;
    super.initState();
  }

  // elevation: 10,
  void _searchEvents(String enteredval) {
    List results = [];
    if (enteredval.isEmpty) {
      results = entreeventsList;
    } else {
      results = entreeventsList
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
        //        Navigator.of(context).push(MaterialPageRoute(
        //             builder: (context) => EntreChatpage(),
        //           ));
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
                            builder: (context) => const Entrewedding()));
                        break;
                      case 1:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrebirthday()));
                        break;
                      case 2:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrehousewarming()));
                        break;
                      case 3:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrebabyshower()));
                        break;
                      case 4:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entreparty()));
                        break;
                      case 5:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entremehndi()));
                        break;
                      case 6:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrebridalshower()));
                        break;
                      case 7:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entreotherpro()));
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
       bottomNavigationBar: EntremyNav(
        index: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Entrebottomnav(
                      indexnum: 0,
                    )));
          } else if (index == 1) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Entrebottomnav(
                      indexnum: 1,
                    )));
          }
        },
      ),
    );
  }
}
