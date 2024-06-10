import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/otppage/signupotp.dart';
import 'package:main_project/firebasee/firebase.dart';
import 'package:main_project/model/enterprenurmodel.dart';
import 'package:main_project/controller/AuthProvider.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Entresignup extends StatefulWidget {
  const Entresignup({super.key});

  @override
  State<Entresignup> createState() => _LogaState();
}

class _LogaState extends State<Entresignup> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final _formkey = GlobalKey<FormState>();
  String? _password;
  String? _confirmPassword;
  @override
  Widget build(BuildContext context) {
    final functionprovider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
       
                    const SizedBox(height: 60),
                    const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("User Name"),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: functionprovider.entername,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters long';
                        }
                        if (value.length > 20) {
                          return 'Name can be at most 20 characters long';
                        }
                        if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Name cannot contain special characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: ("Enter Your Name"),
                          prefixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Mobile Number"),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: functionprovider.enternumber,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Invalid phone number format';
                        }
      
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length == 10) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: ("Enter Your Number"),
                        prefixIcon: const Icon(Icons.call),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Email"),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: functionprovider.enteremail,
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
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Password"),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: functionprovider.enterpassword,
                      obscureText: _obscureText1,
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
                              _obscureText1 = !_obscureText1;
                            });
                          },
                          child: Icon(
                            _obscureText1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Please enter your password';
                        }
      
                        // Password length should be at least 4 characters
                        if (password.length < 4) {
                          return 'Password must be at least 4 characters long.';
                        }
      
                        // Password should contain at least one digit
                        if (!password.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one digit.';
                        }
      
                        _password = password; // Save the password
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Confirm Password"),
                    const SizedBox(height: 7),
                    TextFormField(
                        validator: (password) {
                          _confirmPassword =
                              password; // Save the confirmed password
                          return null;
                        },
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: ("Confirm Password"),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(child: Consumer<FunctionProvider>(
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
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 230, 27, 75))),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await functionprovider.SignupEnterprenur(
                                  context,
                                  functionprovider.enteremail.text,
                                  functionprovider.enterpassword.text,
                                );
                                // .then((value) async {
                                  // await instance.addEnterprenur(
                                  //   EnterprenurModel(
                                  //     EnterprenurName:
                                  //         functionprovider.entername.text,
                                  //     EnterprenurNumber:
                                  //         functionprovider.enternumber.text,
                                  //     EnterprenurEmail:
                                  //         functionprovider.enteremail.text,
                                  //     EnterprenurPassword:
                                  //         functionprovider.enterpassword.text,
                                  //     image: '',
                                  //     businesname: '',
                                  //     location: '',
                                  //     // uid: value.uid,
                                  //   ),
                                  // );
                                // });
                                SuccesToast(context, 'Succes loggin enterprenur');
                              }
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ));
                      },
                    )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
