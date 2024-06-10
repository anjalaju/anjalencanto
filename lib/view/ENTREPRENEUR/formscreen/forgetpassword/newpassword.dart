import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/forgetpassword/passwordchanged.dart';


class Entrenewpassword extends StatefulWidget {
  const Entrenewpassword({super.key});

  @override
  State<Entrenewpassword> createState() => _EntrenewpasswordState();
}

class _EntrenewpasswordState extends State<Entrenewpassword> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final _formkey = GlobalKey<FormState>();
  String? _password;
  String? _confirmPassword;
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
                  "Enter New Password",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                const SizedBox(height: 20),
                const Text(
                  "Your new password must be differentfrom previously used password",
                  style: TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 217, 217, 217)),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextFormField(
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
                  obscureText: _obscureText1,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: ("New Password"),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Please re-enter your password';
                    }

                    // Password length should be at least 4 characters
                    if (password.length < 4) {
                      return 'Password must be at least 4 characters long.';
                    }

                    // Password should contain at least one digit
                    if (!password.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one digit.';
                    }

                    if (password != _password) {
                      return 'Passwords do not match';
                    }

                    _confirmPassword = password; // Save the confirmed password
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
                      onTap: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                      child: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 90, vertical: 60),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.verified_user_outlined,
                                    color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Changed Successfully',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            duration: const Duration(seconds: 3),
                          ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Entrepassdchanged()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                borderRadius: BorderRadius.circular(10.0)),
                            duration: const Duration(seconds: 3),
                          ));
                        }
                      },
                      child: const Text(
                        "Continue",
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
