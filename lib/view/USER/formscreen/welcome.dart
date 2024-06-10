import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_project/view/USER/formscreen/loginpage.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _LogaState();
}

class _LogaState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    // onWillPop: () async {
    //   // Close the app when back button is pressed
    //   return Future.value(false);
    // },
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Container(
                      height: 370,
                      width: 370,
                      // color: Colors.red,

                      child: const Image(
                        image: AssetImage(
                          "images/logo.png",
                        ),
                        // fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              20))),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(280, 50)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 230, 27, 75))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginpage()));
                          },
                          child: const Text(
                            "WELCOME",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Colors.white),
                          )),
                    ),
                  ]),
            ),
          )),
    );
  }

      Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
