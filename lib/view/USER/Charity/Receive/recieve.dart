import 'package:flutter/material.dart';
import 'package:main_project/view/USER/Charity/Receive/Decoration.dart';
import 'package:main_project/view/USER/Charity/Receive/Receidress.dart';
import 'package:main_project/view/USER/Charity/Receive/jewellery.dart';
import 'package:main_project/view/USER/Charity/Receive/otheracc.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';

class Receive extends StatefulWidget {
  const Receive({super.key});

  @override
  State<Receive> createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
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
          'Receive',
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
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => Chatpage(),
        //         ));
        //       },
        //       icon: const Icon(Icons.chat_outlined))
        // ],
      ),
      backgroundColor: const Color(0xffF9F8C9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: const SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(
                      "images/Receive.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Receivedress(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, border: Border.all()),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    AssetImage("images/Donatedress.jpg"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Dress")
                            ],
                          ),
                          height: 180,
                          width: 165,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Receuvejewell(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, border: Border.all()),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    AssetImage("images/Donatejewell.jpg"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Jewellery")
                            ],
                          ),
                          height: 180,
                          width: 165,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Receivedecor(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, border: Border.all()),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  AssetImage("images/Donatedecor.jpg"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Decoration items")
                          ],
                        ),
                        height: 180,
                        width: 165,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const REceivedaccesss(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, border: Border.all()),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  AssetImage("images/Donateaccesss.jpeg"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Other  Accessories")
                          ],
                        ),
                        height: 180,
                        width: 165,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
