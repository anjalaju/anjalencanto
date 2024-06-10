import 'package:flutter/material.dart';
import 'package:main_project/view/USER/catergories/cakes.dart';
import 'package:main_project/view/USER/catergories/cardmakers.dart';
import 'package:main_project/view/USER/catergories/catering.dart';
import 'package:main_project/view/USER/catergories/gifts.dart';
import 'package:main_project/view/USER/catergories/musicanddancr.dart';
import 'package:main_project/view/USER/catergories/photographers.dart';
import 'package:main_project/view/USER/catergories/planninganddecor.dart';
import 'package:main_project/view/USER/events/housewarminglist.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';

class Housewarmingpage extends StatefulWidget {
  const Housewarmingpage({super.key});

  @override
  State<Housewarmingpage> createState() => _HousewarmingpageState();
}

class _HousewarmingpageState extends State<Housewarmingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
          title: const Text(
            'House Warming',
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
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const Shortlist()));
          //       },
          //       icon: const Icon(Icons.favorite)),
          //   IconButton(
          //       onPressed: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => Chatpage(),
          //         )
          //         );
          //       },
          //       icon: const Icon(Icons.chat_outlined))
          // ]
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: Housewarminglist.length,
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
                            builder: (context) => const Photographerspage()));
                        break;
                      case 1:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cateringpage()));
                        break;
                      case 2:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const planninganddecor()));
                        break;
                      case 3:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Giftspage()));
                        break;
                      case 4:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cakespage()));
                        break;
                      case 5:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const musicanddancepage()));
                        break;
                      case 6:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cardmakerspage()));
                        break;

                      // Add more cases if needed for different index values
                    }
                  },
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    color: Housewarminglist[index]["Color"],
                    // color: const Color.fromARGB(255, 248, 194, 168),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${Housewarminglist[index]["Title"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              Housewarminglist[index]["subtitle"] == null
                                  ? Text("")
                                  : Text(
                                      "${Housewarminglist[index]["subtitle"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomLeft: Radius.circular(60)),
                          child: Image.asset(
                            "${Housewarminglist[index]["Image"]}",
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
    );
  }
}
