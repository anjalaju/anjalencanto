// Assuming you have a function to update the business name in Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> updateMobileNumber(String userId, String newMobileNumber) async {
  try {
    await FirebaseFirestore.instance
        .collection('firebase')
        .doc(userId)
        .update({'Mobile_No': newMobileNumber});
  } catch (e) {
    print('Error updating mobile number: $e');
    // Handle error
  }
}

// Widget for editing mobile number page
class EditMobileNum extends StatefulWidget {
  const EditMobileNum({Key? key}) : super(key: key);

  @override
  _EditMobileNumState createState() => _EditMobileNumState();
}

class _EditMobileNumState extends State<EditMobileNum> {
  late TextEditingController _mobileNumController;

  @override
  void initState() {
    super.initState();
    _mobileNumController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileNumController.dispose();
    super.dispose();
  }

  void _submit() async {
    String newMobileNumber = _mobileNumController.text.trim();
    if (newMobileNumber.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await updateMobileNumber(user.uid, newMobileNumber);
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
          'Edit Mobile Number',
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
                const Text('Enter new Mobile Number:'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _mobileNumController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New Mobile Number',
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
