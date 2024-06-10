import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/forgetpassword/forgetotp.dart';



class Entreforgetpage extends StatefulWidget {
  const Entreforgetpage({super.key});

  @override
  State<Entreforgetpage> createState() => _EntreforgetpageState();
}

class _EntreforgetpageState extends State<Entreforgetpage> {
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
              const SizedBox(height: 130),
              const Center(
                  child: Text(
                "Forget Password?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              )),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "we’ll send a verification code",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 217, 217, 217)),
                ),
              ),
              const Center(
                child: Text(
                  " to this email or phone number",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 217, 217, 217)),
                ),
              ),
              const SizedBox(height: 80),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: ("Enter Your Email/phone no"),
                ),
              ),
             
              const SizedBox(
                height: 80,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadiusDirectional.circular(10))),
                        minimumSize: MaterialStateProperty.all(const Size(280, 50)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 230, 27, 75))),
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder:(context) => Entreforgetotp()));
                    },
                    child: const Text(
                      "Send code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
