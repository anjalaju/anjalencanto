import 'package:flutter/material.dart';
import 'dart:async';

import 'package:main_project/usertype.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserType(), 
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  width: double.infinity,
      height: double.infinity,
      color: const Color(0xffE72245),
        child: Center(
          child: Image.asset('images/logo.png'), // Update with your image asset
        ),
      ),
    );
  }
}
