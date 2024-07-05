import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/utils/String.dart';

class Settingchangepass extends StatefulWidget {
  const Settingchangepass({super.key});

  @override
  State<Settingchangepass> createState() => _SettingchangepassState();
}

class _SettingchangepassState extends State<Settingchangepass> {
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            thickness: 2,
            color: Colors.black,
            height: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              TextFormField(
                controller: _currentPassController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: ("         Current Password"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _newPassController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: ("        New Password"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _confirmPassController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: ("         Confirm Password"),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10))),
                          minimumSize:
                              MaterialStateProperty.all(const Size(280, 50)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffE46060))),
                      onPressed: () {
                          String currentPassword = _currentPassController.text.trim();
                      String newPassword = _newPassController.text.trim();
                      String confirmPassword = _confirmPassController.text.trim();

                      // Check if new password and confirm password match
                      if (newPassword != confirmPassword) {
                        // Show error or toast indicating passwords don't match
                        Infotoast(context,"Passwords do not match");
                        return;
                      }

                      // Call method to change password
                      changePassword(newPassword);
                    
                        // changePassword(_newPassController.text);
                        // Navigator.push(context, MaterialPageRoute(builder:(context) => loginnotification()));
                      },
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> changePassword(String newPassword) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   // Get the current user
  //   User? user = _auth.currentUser;

  //   if (user != null) {
  //     try {
  //       await user.updatePassword(newPassword);
  //       print("Password updated successfully");
  //       SuccesToast(context, 'Password updated successfully');
  //     } catch (error) {
  //       print("Error updating password: $error");
  //       // Handle error appropriately, e.g., show error message
  //       Infotoast(context, 'Error updating password: $error');
  //     }
  //   } else {
  //     // No user is signed in.
  //     print("No user signed in");
  //     // Handle no user signed in scenario
  //     Infotoast(context, 'No user signed in');
  //   }
  // }
   Future<void> changePassword(String newPassword) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    // Get the current user
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Reauthenticate the user first
        String currentPassword = _currentPassController.text.trim();
        var credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPassword);
        print("Password updated successfully");
        SuccesToast(context, 'Password updated successfully');
      } catch (error) {
        print("Error updating password: $error");
        String errorMessage = "Error updating password";

        // Handle specific error scenarios
        if (error is FirebaseAuthException) {
          if (error.code == 'wrong-password') {
            errorMessage = "Incorrect current password";
          }
        }

         Infotoast(context, '$errorMessage');
      }
    } else {
      // No user is signed in.
      print("No user signed in");
     Infotoast(context, 'No user signed in');
    }
  }


}
