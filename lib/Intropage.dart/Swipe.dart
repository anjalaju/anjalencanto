// import 'package:flutter/material.dart';
// import 'package:main_project/formscreen/welcome.dart';

// class Swipepage extends StatefulWidget {
//   const Swipepage({super.key});

//   @override
//   State<Swipepage> createState() => _SwipepageState();
// }

// class _SwipepageState extends State<Swipepage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//           length: 4,
//           child: TabBarView(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.height,
//                 color: Color(0xffE72245),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Image(
//                         image: AssetImage(
//                           "images/logo.png",
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   image: AssetImage("images/swipea.jpg"),
//                   fit: BoxFit.cover,
//                 )),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 600),
//                   child: Center(
//                     child: Text(
//                       "Join us at Encanto and let your curiosity thrive",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   image: AssetImage("images/Swipeb.jpg"),
//                   fit: BoxFit.cover,
//                 )),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 600),
//                   child: Center(
//                     child: Text(
//                       "Let's sprinkle some enchantment on your event",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   image: AssetImage("images/Swipec.jpg"),
//                   fit: BoxFit.cover,
//                 )),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 600),
//                   child: Center(
//                     child: Text(
//                       "THE COMPLETE EVENT SOLUTION",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               welcome()
//             ],
//           )),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:main_project/Intropage.dart/swipee.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashUserFirst extends StatefulWidget {
  @override
  State<SplashUserFirst> createState() => _SplashUserFirstState();
}

class _SplashUserFirstState extends State<SplashUserFirst> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () => check());
    super.initState();
  }

  check() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? name = preferences.getString('isloggin');

    if (name != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => bottomnavipage(
              indexnum: 0,
            ),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Swipee(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xffE72245),
      child: Center(
        child: Image.asset("images/logo.png"),
      ),
    );
  }
}

// SplashScreenView(
//       navigateRoute: Swipee(),
//       duration: 4000,
//       imageSize: 250,
//       imageSrc: ,
//       text: "",
//       textType: TextType.TyperAnimatedText,
//       textStyle: TextStyle(fontSize: 30),
//       backgroundColor:Color(0xffE72245)
//     );
