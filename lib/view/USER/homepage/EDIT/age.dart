// Assuming you have a function to update the age in Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> updateAge(String userId, int newAge) async {
  try {
    await FirebaseFirestore.instance
        .collection('firebase')
        .doc(userId)
        .update({'Age': newAge});
  } catch (e) {
    print('Error updating age: $e');
    // Handle error
  }
}

// Widget for editing age page
class AgeEditPage extends StatefulWidget {
  const AgeEditPage({Key? key}) : super(key: key);
             
  @override
  _AgeEditPageState createState() => _AgeEditPageState();
}

class _AgeEditPageState extends State<AgeEditPage> {
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _submit() async {
    int newAge = int.tryParse(_ageController.text.trim()) ?? 0;
    if (newAge > 0) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await updateAge(user.uid, newAge);
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
          'Edit Age',
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
                const Text('Enter new Age:'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New Age',
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
