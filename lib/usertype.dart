import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:main_project/Intropage.dart/Swipe.dart';
import 'package:main_project/Intropage.dart/swipee.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/welcome.dart';

import 'package:main_project/utils/String.dart';
import 'package:main_project/view/admin/drawer.dart';
import 'package:main_project/view/admin/login.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/firstintropage.jpg"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    if(kIsWeb)
                    GestureDetector(
                      onTap: (){
                        
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>   Drawerpage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFF004D),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        // width: Helper.W(context) * .250,
                        // height: Helper.h(context) * .050,
                        width: Helper.W(context) * .500,
                        height: Helper.h(context) * .050,
                      
                        child: const Text(
                          'Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Helper.h(context) * .020,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EntrewelcomeEnterpRenur(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFF004D),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: Helper.W(context) * .500,
                        height: Helper.h(context) * .050,
                        child: const Text(
                          'Entrepreneur',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Helper.h(context) * .020,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Swipee(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFF004D),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: Helper.W(context) * .500,
                        height: Helper.h(context) * .050,
                        child: const Text(
                          'User',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
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
