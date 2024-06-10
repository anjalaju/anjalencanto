import 'package:flutter/material.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';


class loginnotification extends StatefulWidget {
  const loginnotification({super.key});

  @override
  State<loginnotification> createState() => _loginnotificationState();
}

class _loginnotificationState extends State<loginnotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Center(
                  child: Text(
                "Allow notifications on the next screen for:",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 73,
                  width: 372,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Alert of new messages from",
                          style: TextStyle(fontSize: 20)),
                      Text("suppliers you’ve contacted.",
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 229, 213),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 73,
                  width: 372,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Epic offers for your events..",
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 229, 213),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 73,
                  width: 372,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Notifications of news and",
                          style: TextStyle(fontSize: 20)),
                      Text("updates in the app.",
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 229, 213),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                "You can change this option later in your Settings",
                style: TextStyle(fontSize: 23, color: Colors.black),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadiusDirectional.circular(10))),
                        minimumSize: MaterialStateProperty.all(const Size(280, 50)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(252, 244, 125, 35))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>bottomnavipage(indexnum: 0)));
                    },
                    child: const Text(
                      "Next",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(child: Text("privacy Policy"))
            ],
          ),
        ),
      ),
    );
  }
}
