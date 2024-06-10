import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/rentaldress.dart';
import 'package:main_project/view/ENTREPRENEUR/catergories/rentaljewellery.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/bottomnav.dart';


class Entrerentalpage extends StatefulWidget {
  const Entrerentalpage({super.key});

  @override
  State<Entrerentalpage> createState() => _EntrerentalpageState();
}

class _EntrerentalpageState extends State<Entrerentalpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      appBar: AppBar(
        title: const Text(
          'Rentals',
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
        //   }, icon: const Icon(Icons.favorite)),
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        // ]
      ),
      backgroundColor:Color(0xccF17474),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(
                            "Rental Dress",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.library_books_outlined),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
                          trailing: Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Entrerentaldresspage()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(
                            "Rental Jewellery ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          leading: Icon(Icons.library_books_outlined),
                          iconColor: Color.fromRGBO(0, 0, 0, 1),
                           trailing: Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Entrerentjewellpage()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
