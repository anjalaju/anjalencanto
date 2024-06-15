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

  final String adminEmail = "anjaladmin@gmail.com";
  final String adminPassword = "anjaladmin123";

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text);

      if (userCredential.user != null &&
          emailController.text == adminEmail &&
          passwordController.text == adminPassword) {
        // Store login attempt in Firestore
        await FirebaseFirestore.instance.collection('admin').doc('adminDoc').set({
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
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
