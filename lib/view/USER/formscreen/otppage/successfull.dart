import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/view/USER/formscreen/loginnotifi.dart';

class successfull extends StatefulWidget {
  const successfull({super.key});

  @override
  State<successfull> createState() => _successfullState();
}

class _successfullState extends State<successfull>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
    _controller.forward();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const loginnotification()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.indigo),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Icon(
                        Icons.check,
                        size: 100 * _animation.value,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    'Successfull',
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Times New Roman',
                          fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Your mobile number has been',
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Successfully Verified',
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
