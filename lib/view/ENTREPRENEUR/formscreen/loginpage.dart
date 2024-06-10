import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/forgetpassword/forgetpage.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/loginnotifi.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/signup.dart';
import 'package:main_project/controller/AuthProvider.dart';
import 'package:provider/provider.dart';

class Entreloginpage extends StatefulWidget {
  const Entreloginpage({super.key});

  @override
  State<Entreloginpage> createState() => _LogaState();
}

class _LogaState extends State<Entreloginpage> {
  bool _obscureText = true;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
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
                    controller: authprovider.enteremail,
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
                    controller: authprovider.enterpassword,
                    validator: (password) {
                      // Password length should be at least 8 characters
                      if (password!.length < 4) {
                        return 'Password must be at least 4 characters long.';
                      }

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
                      ),
                    ),
                  ),
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
                                  builder: (context) => const Entreforgetpage(),
                                ));
                          },
                          child: const Text("Forgot Password?"))
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Center(child: Consumer<AuthProvider>(
                    builder: (context, instance, child) {
                      return ElevatedButton(
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
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              await instance.signin(
                                  authprovider.enteremail.text,
                                  authprovider.enterpassword.text,
                                  context).then((value){
                                    
                                  });

                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ));
                    },
                  )),
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
                      Text("Don't have an account? "),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) => Entresignup()))),
                        child: Text(
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
