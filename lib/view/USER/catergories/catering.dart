import 'package:flutter/material.dart';
import 'package:main_project/view/USER/catogories2/catering/HyderabadyDishes.dart';
import 'package:main_project/view/USER/catogories2/catering/briyanidishes%20.dart';
import 'package:main_project/view/USER/catogories2/catering/nadansadhya.dart';
import 'package:main_project/view/USER/catogories2/catering/othersnacks.dart';
import 'package:main_project/view/USER/catogories2/catering/westerndishes.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';

class Cateringpage extends StatefulWidget {
  const Cateringpage({super.key});

  @override
  State<Cateringpage> createState() => _CateringpageState();
}

class _CateringpageState extends State<Cateringpage> {
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
          }
           else if (index == 4) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => bottomnavipage(
                      indexnum: 4,
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
         actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
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
                              Navigator.push(context, MaterialPageRoute(builder:(context) => Westerndishes()));
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Nadansaddya()));
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Hyderabady()));
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Biriyani()));
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Othersnacks()));
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