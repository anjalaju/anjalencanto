import 'package:flutter/material.dart';
import 'package:main_project/usertype.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/ENTREPRENEUR/Charity/Homepage.dart';
import 'package:main_project/view/ENTREPRENEUR/events/eventpage.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/welcome.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/Offer.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/booking_details.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/complaints.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/detailspage.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/notificationsend.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/review.dart';
import 'package:main_project/view/ENTREPRENEUR/homepage/settings.dart';

class EntreHome extends StatefulWidget {
  const EntreHome({super.key});

  @override
  State<EntreHome> createState() => _EntreHomeState();
}

class _EntreHomeState extends State<EntreHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: const Center(
                                          child: Column(
                                        children: [
                                          Text(
                                            "Logout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Are You Sure?",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.indigo),
                                            ),
                                            style: TextButton.styleFrom(
                                                elevation: 5,
                                                minimumSize:
                                                    const Size(128, 46),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ))),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UserType(),
                                                  ),
                                                  (route) => false);
                                            },
                                            child: const Text(
                                              "Yes",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            style: TextButton.styleFrom(
                                                elevation: 5,
                                                minimumSize:
                                                    const Size(128, 46),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ))),
                                      ]);
                                },
                              );
                            },
                            child: const Card(
                              color: Color(0xffF9F8C9),
                              child: SizedBox(
                                width: 100,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Logout'),
                                  ],
                                ),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Entrenotificationpage(),
                                  ));
                                },
                                icon: const Icon(Icons.notifications)),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const EntreSettingpage(),
                                ));
                              },
                              icon: const Icon(Icons.settings),
                            ),
                            IconButton(
                                onPressed: () {
                                 Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const BookingDetails(),
                                ));
                                },
                                icon: const Icon(Icons.access_alarms)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xffFF004D),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            'images/logo.png',
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Entredetailspage(),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xff3BAA54),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Add your Product',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Entreeventpage(),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffBF68E8)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.grid_view,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('View all',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Entreofferpage(),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffFA5993)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_offer_sharp,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Offers',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Entrecomplaint(),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffC1D112),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit_square,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Complaints',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReviewPage(),
                                ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 10,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 103, 118, 205),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit_calendar,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Review',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EntreCharityhomepage(),
                                ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 10,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffFC3C3C),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.handshake_outlined,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Charity',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
