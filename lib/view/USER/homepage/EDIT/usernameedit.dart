import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> updateName(String userId, String newName) async {
  try {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(newName); // Update user's name
      await FirebaseFirestore.instance
          .collection('firebase')
          .doc(userId)
          .update({'User_Name': newName}); // Update name in Firestore
    }
  } catch (e) {
    print('Error updating name: $e');
    // Handle error
  }
}

class NameEditPage extends StatefulWidget {
  const NameEditPage({Key? key}) : super(key: key);

  @override
  _NameEditPageState createState() => _NameEditPageState();
}

class _NameEditPageState extends State<NameEditPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() async {
    String newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await updateName(user.uid, newName); // Call function to update name
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
          'Edit Name',
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
                const Text('Enter new Name:'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New Name',
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
