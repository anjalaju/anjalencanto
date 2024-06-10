import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/otppage/successfull.dart';



class Entresignupotp extends StatefulWidget {
  const Entresignupotp({super.key});

  @override
  State<Entresignupotp> createState() => _LogaState();
}

class _LogaState extends State<Entresignupotp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(129, 146, 204, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Verification code",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "Send to +917994413795",
                  style: TextStyle(color: Colors.white),
                )),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If You Dont’t Recieve Code? ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Resend ",
                      style: TextStyle(color: Colors.pink, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10))),
                          minimumSize: MaterialStateProperty.all(Size(280, 50)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 230, 27, 75))),
                      onPressed: () {
Navigator.push(context, MaterialPageRoute(builder:(context) => Entresuccessfull()));

                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
