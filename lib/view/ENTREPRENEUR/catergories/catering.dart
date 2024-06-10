import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/catogories2/catering/HyderabadyDishes.dart';
import 'package:main_project/view/ENTREPRENEUR/catogories2/catering/briyanidishes%20.dart';
import 'package:main_project/view/ENTREPRENEUR/catogories2/catering/nadansadhya.dart';
import 'package:main_project/view/ENTREPRENEUR/catogories2/catering/othersnacks.dart';
import 'package:main_project/view/ENTREPRENEUR/catogories2/catering/westerndishes.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/bottomnav.dart';


class Entrecateringpage extends StatefulWidget {
  const Entrecateringpage({super.key});

  @override
  State<Entrecateringpage> createState() => _EntrecateringpageState();
}

class _EntrecateringpageState extends State<Entrecateringpage> {
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
          'Catering',
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
        // ],
      ),
      backgroundColor:Color(0xffCDEEDC),

body:

 Column(

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
                            title: Text("Western Dishes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                         
                            textColor: Color.fromARGB(255, 0, 0, 0),
                            leading: Icon(Icons.library_books_outlined),
                            iconColor: Color.fromRGBO(0, 0, 0, 1),
                           
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => Entrepwesterndish()));
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
                        title: Text("Nadan Sadhya ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                     
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        leading: Icon(Icons.library_books_outlined),
                        iconColor: Color.fromRGBO(0, 0, 0, 1),
                       
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Entrepnadansadya()));
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
                        title: Text("Hyderabady Dishes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                     
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        leading: Icon(Icons.library_books_outlined),
                        iconColor: Color.fromRGBO(0, 0, 0, 1),
                       
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Entrephyderabad()));
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
                        title: Text("Biriyani Dishes ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                     
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        leading: Icon(Icons.library_books_outlined),
                        iconColor: Color.fromRGBO(0, 0, 0, 1),
                       
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Entrepbiriyani()));
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
                        title: Text("Other snacks",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                     
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        leading: Icon(Icons.library_books_outlined),
                        iconColor: Color.fromRGBO(0, 0, 0, 1),
                       
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Entrepsnacks()));
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