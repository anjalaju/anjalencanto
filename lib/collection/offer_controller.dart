import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/model/offer_model.dart';
// import 'package:terra_treasures/model/user_model.dart';

class Offercontroller {
  final db = FirebaseFirestore.instance;

  Future<void> addoffer(Offermodel offermodel, String uid) async {
    final offermap = offermodel.tomap();
    final docRef = db.collection("Offer").doc(uid);
    await docRef.set(offermap);
    fetchAlloffer();
  }

  Future<void> create(String image) async {
    final collectionRef = FirebaseFirestore.instance.collection('Offer');
    await collectionRef.add({
      'Image': image,
    });
  }

  List<Offermodel> listOfData = [];

  Future<List<Offermodel>> fetchAlloffer() async {
    final snapshot = await db.collection("Offer").get();
    listOfData =
        snapshot.docs.map((e) => Offermodel.fromMap(e.data())).toList();
    print(listOfData);
    return listOfData;
  }

  Offermodel? singleUserData;

  Future<void> fetchSingleofferData(String id) async {
    final snapshot = await db.collection("Offer").doc(id).get();
    singleUserData = Offermodel.fromMap(snapshot.data()!);
  }

  Future<XFile?> pickImage() async {
    final imagePicker = ImagePicker();
    return await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
  }

  Future<String> uploadImage(XFile imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('images/${imageFile.name}');
    try {
      final uploadTask = storageRef.putFile(File(imageFile.path));
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.message);
      return '';
    }
  }
}
