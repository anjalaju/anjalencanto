import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/loginnotifi.dart';

class Entresuccessfull extends StatefulWidget {
  const Entresuccessfull({super.key});

  @override
  State<Entresuccessfull> createState() => _EntresuccessfullState();
}

class _EntresuccessfullState extends State<Entresuccessfull> {
  void initState() {
    super.initState();
    // Wait for 3 seconds and then navigate to the login page
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Entreloginnotification()),(route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  // color: Colors.red,

                  // child: Image(
                  //   image: AssetImage(
                  //     "images/blueverifi.png",
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
                  //color add code

                  // child: ColorFiltered(
                  //   colorFilter: const ColorFilter.mode(
                  //     Colors.blue, // Change the color here
                  //     BlendMode
                  //         .modulate, // You can try different BlendModes for different effects
                  //   ),
                  //   child: Image.asset(
                  //     'images/verify.gif', // Replace with your GIF file path
                  //     width: 300,
                  //     height: 400,
                  //   ),
                  // ))),
                  // without color
                  child: Image.asset(
                    'images/verify.gif', // Replace with your GIF file path
                    width: 300,
                    height: 400,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Center(
                  child: Text(
                "Successful",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              )),
              const SizedBox(height: 20),
              const Text(
                "     Your mobile number has been Successfully Verified",
                style: TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 217, 217, 217)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
