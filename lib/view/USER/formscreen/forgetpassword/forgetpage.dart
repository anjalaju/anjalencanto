import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpage extends StatefulWidget {
  const Forgetpage({super.key});

  @override
  State<Forgetpage> createState() => _ForgetpageState();
}

class _ForgetpageState extends State<Forgetpage> {
  final emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String email = "";
  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email has been sent')),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formkey,
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
                TextFormField(
                  controller: emailcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // hintText: ("Enter Your Email/phone no"),
                    hintText: ("Enter Your Email"),
                  ),
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
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = emailcontroller.text;
                            resetPassword();
                          });
                        }
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => forgetotp()));
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
      ),
    );
  }
}
