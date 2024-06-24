import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/USER/formscreen/forgetpassword/forgetpage.dart';
import 'package:main_project/view/USER/formscreen/loginnotifi.dart';
import 'package:main_project/view/USER/formscreen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _LogaState();
}

class _LogaState extends State<loginpage> {
  String email = " ", password = "";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _obscureText = true;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;

  // login() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   if (password != null) {
  //     try {
  //       setState(() {
  //         isloading = true;
  //       });
  //       UserCredential credential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);
  //       print('${credential.user!.uid}***************');
  //       preferences.setString('isloggin', credential.user!.uid);

  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Login successfull')));
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const loginnotification(),
  //           ));
  //       setState(() {
  //         isloading = false;
  //       });
  //     } on FirebaseAuthException catch (e) {
  //       setState(() {
  //         isloading = false;
  //       });
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Something wrong!!!')));
  //       if (e.code == 'weak-password') {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(const SnackBar(content: Text('weak password')));
  //       } else if (e.code == 'email-already-in-use') {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(const SnackBar(content: Text('email already use')));
  //       }
  //     }
  //   }
  // }



Future<void> login() async {
  try {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    final snapshot = await db
        .collection('firebase')
        .where('Id', isEqualTo: uid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const loginnotification(),
        ),
      );
      SuccesToast(context, 'Login success');
      
    } else {
      Infotoast(context, 'User not found');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Infotoast(context, 'No user found for that email');
    } else if (e.code == 'wrong-password') {
      Infotoast(context, 'Wrong password provided for that user');
    } else {
      Infotoast(context, 'Error signing in');
    }
  } catch (e) {
    print(e.toString());
    Infotoast(context, 'Error signing in');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Center(
                    child: Text(
                      "Encanto",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text("Email"),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: emailcontroller,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: ("Enter Your Email"),
                        prefixIcon: const Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Password"),
                  const SizedBox(height: 7),
                  TextFormField(
                      controller: passwordcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (password) {
                        // Password length should be at least 8 characters
                        if (password!.length < 4) {
                          return 'Password must be at least 4 characters long.';
                        }

                        if (!password.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one digit.';
                        }

                        // Password should contain at least one special character
                        // if (!password
                        //     .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        //   return 'Password must contain at least one special character.';
                        // }

                        // Password is valid
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: ("Enter Your Password"),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ))),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Forgetpage(),
                                ));
                          },
                          child: const Text("Forgot Password?"))
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: isloading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10))),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(280, 50)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 230, 27, 75))),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = emailcontroller.text;
                                  password = passwordcontroller.text;
                                });
                                login();
                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                //   margin: const EdgeInsets.symmetric(
                                //       horizontal: 90, vertical: 60),
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 5, vertical: 5),
                                //   content: const Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Icon(Icons.verified_user_outlined,
                                //           color: Colors.white),
                                //       SizedBox(width: 10),
                                //       Text(
                                //         'Login Successfully',
                                //         style: TextStyle(color: Colors.white),
                                //       ),
                                //     ],
                                //   ),
                                //   backgroundColor: Colors.green,
                                //   behavior: SnackBarBehavior.floating,
                                //   elevation: 4.0,
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10.0)),
                                //   duration: const Duration(seconds: 3),
                                // ));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => loginnotification()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 90, vertical: 60),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  content: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'Invalid Credential',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  duration: const Duration(seconds: 3),
                                ));
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      const Text(" Or Login With "),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        // color: Colors.amber,
                        child: const Image(
                            image: AssetImage("images/facebook.png")),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 40,

                        width: 40,

                        // color: Colors.amber,
                        child:
                            const Image(image: AssetImage("images/google.png")),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) => const signup()))),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.pink),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
