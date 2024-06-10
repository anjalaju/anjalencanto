import 'package:flutter/material.dart';
import 'package:main_project/view/USER/homepage/account.dart';
import 'package:main_project/view/USER/homepage/homepage.dart';
import 'package:main_project/view/USER/homepage/notificationpage.dart';
import 'package:main_project/view/USER/homepage/offerpage.dart';
import 'package:main_project/view/USER/homepage/searchpage.dart';

class bottomnavipage extends StatefulWidget {
  int indexnum = 0;

  bottomnavipage({super.key, required this.indexnum});

  @override
  State<bottomnavipage> createState() => _bottomnavipageState();
}

class _bottomnavipageState extends State<bottomnavipage> {
  final _pages = [
    const homepage(),
    const Searchpage(),
    const notificationpage(),
    const offerpage(),
    const Accountpage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.indexnum],
      bottomNavigationBar: myNav(
        index: widget.indexnum,
        onTap: (index) {
          setState(() {
            widget.indexnum = index;
          });
        },
      ),
    );
  }
}

Widget myNav({
  int? index,
  void Function(int)? onTap,
  selectedcolor,
}) {
  return BottomNavigationBar(
    showUnselectedLabels: true,
    currentIndex: index!,
    selectedItemColor: Colors.pink,
    unselectedItemColor: Colors.black,
    showSelectedLabels: true,
    onTap: onTap,
    items: const [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color(0xffB7B7B7)),
      BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Color(0xffB7B7B7)),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
          label: 'Notification',
          backgroundColor: Color(0xffB7B7B7)),
      BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Offers',
          backgroundColor: Color(0xffB7B7B7)),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Account',
          backgroundColor: Color(0xffB7B7B7)),
    ],
  );
}
