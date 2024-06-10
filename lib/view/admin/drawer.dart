 
import 'package:flutter/material.dart';
import 'package:main_project/view/admin/Entrepreneur_details.dart';
import 'package:main_project/view/admin/Notification_page.dart';
import 'package:main_project/view/admin/User_details.dart';
import 'package:main_project/view/admin/login.dart';

class Drawerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,
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
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('images/wedding-management-500x500.webp'),
        //         fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdminLogin(),
                          ));
                    },
                    child: Container(
                      height: 150,
                      width: 250,
                      color: Colors.indigo,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Events',
                            style: TextStyle(color: Colors.white, fontSize: 40),
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
                  child: InkWell(
                    onTap: () {
                      //  Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => const Login(),
                      //     ));
                    },
                    child: Container(
                      height: 150,
                      width: 250,
                      color: Colors.indigo,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Charity',
                            style: TextStyle(color: Colors.white, fontSize: 40),
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
                  child: InkWell(
                    onTap: () {
                      //  Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => const Login(),
                      //     ));
                    },
                    child: Container(
                      height: 150,
                      width: 250,
                      color: Colors.indigo,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Review',
                            style: TextStyle(color: Colors.white, fontSize: 40),
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
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => const Login(),
                      //     ));
                    },
                    child: Container(
                      height: 150,
                      width: 250,
                      color: Colors.indigo,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Complaints',
                            style: TextStyle(color: Colors.white, fontSize: 40),
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Image.asset('images/logo.png')),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
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
              leading: const Icon(Icons.person),
              title: const Text('User details'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  Userdetails(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_rounded),
              title: const Text('Entrepreneur details'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  Entrepreneurdetails(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationPgae(),
                ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
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
                                              // Navigator.of(context)
                                              //     .push(MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       const Login(),
                                              // ));
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
