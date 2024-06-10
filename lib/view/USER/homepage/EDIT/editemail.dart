import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> updateEmail(String userId, String newEmail) async {
  try {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection('firebase')
          .doc(userId)
          .update({'email': newEmail});
    }
  } catch (e) {
    print('Error updating email: $e');
    // Handle error
  }
}

class Emaileditpage extends StatefulWidget {
  const Emaileditpage({Key? key}) : super(key: key);

  @override
  _EmaileditpageState createState() => _EmaileditpageState();
}

class _EmaileditpageState extends State<Emaileditpage> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() async {
    String newEmail = _emailController.text.trim();
    if (newEmail.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await updateEmail(user.uid, newEmail);
        // Optionally, you can navigate back to the previous page or show a success message.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'Edit Email',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter new Email:'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New Email',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shape: const RoundedRectangleBorder(),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _submit();
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
