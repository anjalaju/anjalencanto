import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/USER/formscreen/loginpage.dart';
import 'package:main_project/view/admin/Entrepreneur_details.dart';
import 'package:main_project/view/admin/Notification_page.dart';
import 'package:main_project/view/admin/User_details.dart';
import 'package:main_project/view/admin/charity.dart';
import 'package:main_project/view/admin/complaint.dart';
import 'package:main_project/view/admin/eventsviw_admin.dart';
import 'package:main_project/view/admin/login.dart';
import 'package:main_project/view/admin/offers.dart';
import 'package:main_project/view/admin/reviewview.dart';

class Drawerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Welcome To Encanto',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: const Color(0xffE72245),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/adminfrontpage.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EventViewAdmin(),
                      ));
                    },
                    child: Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Color(0xff1679AB),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Events',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CharityAdmin(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1679AB),
                          borderRadius: BorderRadius.circular(20)),
                      height: 150,
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Charity',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ReviewViewAdmin(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1679AB),
                          borderRadius: BorderRadius.circular(20)),
                      height: 150,
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reviews',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Complaintadmin(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1679AB),
                          borderRadius: BorderRadius.circular(20)),
                      height: 150,
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Complaints',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Card(
                //   child: Container(
                //     height: 150,
                //     width: 250,
                //     color: Colors.indigo,
                //     child: const Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Total users',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         Text('10', style: TextStyle(color: Colors.white)),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff6C6974),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Image.asset('images/logo.png')),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Drawerpage(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: const Text('User details',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Userdetails(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_rounded, color: Colors.black),
              title: const Text('Entrepreneur details',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Entrepreneurdetails(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading:
                  const Icon(Icons.notifications_active, color: Colors.black),
              title: const Text('Notifications',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationPgae(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading:
                  const Icon(Icons.local_offer, color: Colors.black),
              title: const Text('Offers',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Adminoffers(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        title: const Center(
                            child: Column(
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Are You Sure?",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
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
                                style: TextStyle(color: Colors.indigo),
                              ),
                              style: TextButton.styleFrom(
                                  elevation: 5,
                                  minimumSize: const Size(128, 46),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ))),
                          ElevatedButton(
                              onPressed: () {
                                auth.signOut().then(
                                  (value) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminLogin(),
                                      ),
                                      (route) => false,
                                    );
                                            SuccesToast(context, 'Logout Succes');
                                  },
                                );
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
                              ),
                              style: TextButton.styleFrom(
                                  elevation: 5,
                                  minimumSize: const Size(128, 46),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ))),
                        ]);
                  },
                );
              },
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
