import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/view/USER/formscreen/welcome.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class Swipee extends StatefulWidget {
  const Swipee({super.key});

  @override
  _SwipeeState createState() => _SwipeeState();
}

class _SwipeeState extends State<Swipee> {
  final List<Widget> pages = [Page1(), Page2(), Page3()]; // Fixed here
  final PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                  onPageChanged: (int index) {
                    _currentPageNotifier.value = index;
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20.0, // Adjust the position according to your preference
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CirclePageIndicator(
                    itemCount: pages.length,
                    currentPageNotifier: _currentPageNotifier,
                    selectedDotColor: Colors.pink,
                    dotColor: Colors.white,
                    size: 15,
                    selectedSize: 15,
                    dotSpacing: 50,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  // Changed to StatelessWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/swipea.jpg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Join us at Encanto and let your curiosity thrive',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          )),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  // Changed to StatelessWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "images/Swipeb.jpg",
                  ),
                  fit: BoxFit.fill)),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Text(
                "Let's sprinkle some enchantment on your event",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          )),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  void initState() {
    super.initState();
    
    // Wait for 3 seconds and then navigate to the login page
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => welcome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/Swipec.jpg"), fit: BoxFit.fill)),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             Text(
                'THE COMPLETE EVENT SOLUTION',

                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          )),
    );
  }
}
