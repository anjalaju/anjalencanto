import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/view/USER/formscreen/otppage/successfull.dart';
import 'package:main_project/deno.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signupotp extends StatefulWidget {
  final String verificationid;
  final String mobilenumber;
  final String username;
  final String email;

  signupotp(
      {super.key,
      required this.verificationid,
      required this.mobilenumber,
      required this.email,
      required this.username});

  @override
  State<signupotp> createState() => _signupotpState();
}

class _signupotpState extends State<signupotp> {
  final _formState = GlobalKey<FormState>();

  final otpController = TextEditingController();
  bool isloading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addfirebase(Map<String, dynamic> logininfomap, String userid) async {
    return FirebaseFirestore.instance
        .collection('firebase')
        .doc(userid)
        .set(logininfomap);
  }

  Signup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (password != null) {
      try {
        setState(() {
          isloading = true;
        });
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        preferences.setString('isloggin', credential.user!.uid);
        // Ensure that 'context' is available where this code is executed

        String uid = _auth.currentUser!.uid;
        Map<String, dynamic> registereinfomap = {
          "User_Name": widget.username,
          "Email": widget.email,
          "Age": '',
          "Place": '',
          "Id": uid,
          "Mobile_No": widget.mobilenumber,
          "Image": '',
          "timestamp":DateTime.now(),
        };
        await addfirebase(registereinfomap, uid);
        const SnackBar(content: Text("Details added to firebase Succesfully"));
        setState(() {
          isloading = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('weak password'),
          ));
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('email already  use'),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formState,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    "Send OTP",
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
                      "Verification code",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                 Center(
                    child: Text(
                  "Send to ${widget.mobilenumber}",
                  style: TextStyle(color: Colors.white),
                )),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  height: 60, width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  child: Pinput(
                    length: 6,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter otp";
                      } else {
                        return null;
                      }
                    },
                    controller: otpController,
                    defaultPinTheme: PinTheme(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.grey.shade300,
                            )
                            // border: Border.all(),
                            )),
                    // preFilledWidget: SizedBox(
                    //   height: 4.5.h,
                    //   width: 10.w,
                    // ),
                    // border: Border.all(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If You Dont’t Recieve Code?",
                      style: GoogleFonts.montserrat(fontSize: 11),
                    ),
                    Text(
                      "Resend",
                      style: GoogleFonts.montserrat(
                          fontSize: 11, color: Colors.pink),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: (const Size(280, 50)),
                        foregroundColor: Colors.black,
                        backgroundColor:
                            const Color.fromARGB(255, 230, 27, 75)),
                    onPressed: () async {
                      print("${password}/*/*/*/*//*");
                      print("${email}/*/*/*/*//*");
                      if (_formState.currentState!.validate()) {
                        // verifyotp(context);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: otpController.text);

                        // Sign the user in (or link) with the credential
                        await _auth.signInWithCredential(credential);
                        Signup();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const successfull(),
                            ));
                      }
                    },
                    child: const Text(
                      "Submit",
                    )),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
