import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main_project/view/admin/drawer.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  final String adminEmail = "anjaladmin@gmail.com";
  final String adminPassword = "anjaladmin123";

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null &&
          emailController.text == adminEmail &&
          passwordController.text == adminPassword) {
        // Store login attempt in Firestore
        await FirebaseFirestore.instance
            .collection('admin')
            .doc('adminDoc')
            .set({
          'email': emailController.text,
          'userId': 'adminDoc',
          'loginTime': FieldValue.serverTimestamp(),
        });

        // Navigate to the admin dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Drawerpage()),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid admin credentials'),
        ));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in: ${e.message}'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff219C90),
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
                  controller: emailController,
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
                  // decoration:  InputDecoration(labelText: 'Email'),
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
                    controller: passwordController,
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

                    // decoration: const InputDecoration(labelText: 'Password'),
                    // // obscureText: true,
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
                          onPressed: login,
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
