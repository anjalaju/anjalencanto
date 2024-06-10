import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_project/view/USER/formscreen/forgetpassword/newpassword.dart';


class forgetotp extends StatefulWidget {
  const forgetotp({super.key});

  @override
  State<forgetotp> createState() => _LogaState();
}

class _LogaState extends State<forgetotp> {
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
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    "Enter Your OTP",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please enter the 4 digit code ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      child: TextField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textAlign: TextAlign.center,
                        // obscureText: true,
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
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textAlign: TextAlign.center,
                        // obscureText: true,
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
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textAlign: TextAlign.center,
                        // obscureText: true,
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
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textAlign: TextAlign.center,
                        // obscureText: true,
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
                const SizedBox(
                  height: 100,
                ),
                const Row(
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
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10))),
                          minimumSize:
                              MaterialStateProperty.all(const Size(280, 50)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 230, 27, 75))),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => Newpassword()));
                      },
                      child: const Text(
                        "Verify",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
