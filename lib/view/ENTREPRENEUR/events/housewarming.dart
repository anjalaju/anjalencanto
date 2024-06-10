import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/cakes.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/cardmakers.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/catering.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/gifts.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/musicanddancr.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/photographers.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/planninganddecor.dart';
import 'package:main_project/view/ENTREPRENEUR/events/housewarminglist.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/bottomnav.dart';



class Entrehousewarming extends StatefulWidget {
  const Entrehousewarming({super.key});

  @override
  State<Entrehousewarming> createState() => _EntrehousewarmingState();
}

class _EntrehousewarmingState extends State<Entrehousewarming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(   bottomNavigationBar: EntremyNav(
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
        //  actions: [
        //   IconButton(onPressed: () {
        //        Navigator.of(context).push(MaterialPageRoute(
        //             builder: (context) => EntreChatpage(),
        //           ));
        //   }, icon: const Icon(Icons.chat_outlined))
        // ]
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
      
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: entrehousewarminglist.length,
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
                            builder: (context) => const Entrephotogrpage()));
                        break;
                      case 1:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrecateringpage()));
                        break;
                      case 2:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entreplanningpage()));
                        break;
                      case 3:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entregiftspage()));
                        break;
                      case 4:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrecakespage()));
                        break;
                      case 5:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entremusicpage()));
                        break;
                      case 6:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Entrecardpage()));
                        break;
                     
                      // Add more cases if needed for different index values
                    }
                  },
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    color: entrehousewarminglist[index]["Color"],
                    // color: const Color.fromARGB(255, 248, 194, 168),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                          ),

                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${entrehousewarminglist[index]["Title"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                              ,entrehousewarminglist[index]["subtitle"]==null?Text(""):
                                Text(
                                "${entrehousewarminglist[index]["subtitle"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                            ],
                          ),
                          
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomLeft: Radius.circular(60)),
                          child: Image.asset(
                            "${entrehousewarminglist[index]["Image"]}",
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
