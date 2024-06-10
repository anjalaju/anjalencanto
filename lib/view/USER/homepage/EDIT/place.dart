import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> updatePlace(String userId, String newPlace) async {
  try {
    await FirebaseFirestore.instance
        .collection('firebase')
        .doc(userId)
        .update({'Place': newPlace});
  } catch (e) {
    print('Error updating place: $e');
    // Handle error
  }
}

class PlaceEditPage extends StatefulWidget {
  const PlaceEditPage({Key? key}) : super(key: key);

  @override
  _PlaceEditPageState createState() => _PlaceEditPageState();
}

class _PlaceEditPageState extends State<PlaceEditPage> {
  late TextEditingController _placeController;

  @override
  void initState() {
    super.initState();
    _placeController = TextEditingController();
  }

  @override
  void dispose() {
    _placeController.dispose();
    super.dispose();
  }

  void _submit() async {
    String newPlace = _placeController.text.trim();
    if (newPlace.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await updatePlace(user.uid, newPlace);
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
          'Edit Place',
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
                const Text('Enter new Place:'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New Place',
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
