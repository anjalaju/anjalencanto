import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/model/addreview.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/model/enterprenurmodel.dart';
import 'package:main_project/model/likepostmodel.dart';
import 'package:main_project/model/notificationmodel.dart';
import 'package:main_project/model/userbookingmodel.dart';

class FunctionProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  final bookingname = TextEditingController();
  final bookemail = TextEditingController();
  final bookphonenumber = TextEditingController();
  final bookdiscription = TextEditingController();

  String? bookdata;

  clear() {
    bookingname.clear();
    bookemail.clear();
    bookphonenumber.clear();
    bookdiscription.clear();
    notifyListeners();
  }

  //set

  Future addEnterprenur(EnterprenurModel enterprenurModel, uid) async {
    final snapshot = db.collection('enterprenur').doc(uid);

    snapshot.set(enterprenurModel.toJsone(snapshot.id));
  }

  Future setEvent(EventModel eventModel) async {
    final snapshot = db.collection('AddEvent').doc();

    snapshot.set(eventModel.toJson(snapshot.id));
  }

  //get

  List<EventModel> listevent = [];
  Stream<QuerySnapshot> getEventproject(mainwere, subwere) {
    // final snapshot = db
    //     .collection('AddEvent')
    //     .where('eventmaincategory', isEqualTo: mainwere)
    //     .where('eventsubcategory', isEqualTo: subwere)
    //     .snapshots();

    // snapshot.listen((event) {
    //   listevent = event.docs.map((e) {
    //     return EventModel.fromJsone(e.data());
    //   }).toList();
    // });
    // notifyListeners();

    return db
        .collection('AddEvent')
        .where('eventmaincategory', isEqualTo: mainwere)
        .where('eventsubcategory', isEqualTo: subwere)
        .snapshots();
  }

  // update

  Future updateevent(
      docid, eventname, eventprice, eventplace, eventdiscription, image) async {
    EventModel? eventModel;

    db.collection('AddEvent').doc(docid).update({
      'eventname': eventname,
      'startingprice': eventprice,
      'eventplace': eventplace,
      'eventdiscription': eventdiscription,
      'image': image.isEmpty ? eventModel!.Image : image,
    });

    log('this image sjdja ${eventModel!.Image}');
    // notifyListeners();
  }

  ///delete

  Future deletedoc(docid) async {
    try {
      db.collection('AddEvent').doc(docid).delete();
    } catch (e) {
      log('erro');
    }
    notifyListeners();
  }

  // booking

  Future bookingEvent(BookingModle bookingModle) async {
    final snapshot = db.collection('Boookingevent').doc();

    snapshot.set(bookingModle.tojsone(snapshot.id));
  }

  Stream<QuerySnapshot> getBookingevent(uid) {
    return db
        .collection('Boookingevent')
        .where('Userid', isEqualTo: uid)
        .snapshots();
  }

  Future addCompalint(ComplaintModel complaintModel) async {
    final snapshot = await db.collection('Alert').doc();

    snapshot.set(complaintModel.tojsone(snapshot.id));
  }

  Stream<QuerySnapshot> getAllcomplaint() {
    return db.collection('Alert').snapshots();
  }

  Future addReview(AddReview addReview) async {
    final snapshot = await db.collection('AddReview').doc();

    snapshot.set(addReview.tojsone(snapshot.id));
  }

  Stream<QuerySnapshot> getReview() {
    return db.collection('AddReview').snapshots();
  }

  Future addNotification(NotificationModel notificationModel) async {
    final snapshot = db.collection('Notiication').doc();

    snapshot.set(notificationModel.tojsone(snapshot.id));
  }

  List<NotificationModel> allnoti = [];
  Future getNotificationall() async {
    final snapshot = db.collection('Notiication').snapshots();

    snapshot.listen((event) {
      allnoti = event.docs.map((e) {
        return NotificationModel.fromjsone(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  File? selectedimage;
  String? url;
  Future imagePicker() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage == null) return null;
    selectedimage = File(pickedimage.path);
    notifyListeners();

    //add storage
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    final curenttime = TimeOfDay.now().toString();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('Entureprenur/$curenttime')
        .putFile(selectedimage!, metadata);
    TaskSnapshot snapshot = await uploadTask;

    url = await snapshot.ref.getDownloadURL();
    log('${url.toString()}====================================================');
  }

  Future updatProfiel(uid, bisname, location) async {
    db.collection('enterprenur').doc(uid).update({
      'profileimage': url,
      'businessname': bisname,
      'location': location,
    });
    notifyListeners();
  }

  EnterprenurModel? signleentr;
  Future getEnterprenurdata(uid) async {
    final snapshot = await db.collection('enterprenur').doc(uid).get();

    if (snapshot.exists) {
      signleentr =
          EnterprenurModel.fromjsone(snapshot.data() as Map<String, dynamic>);
    }
  }

  Future likepost(Likepostmodel likepostmodel, id) async {
    final SNAPSHOT = await db.collection('PostLike').doc(id).get();

    if (SNAPSHOT.exists) {
      deletedoc(SNAPSHOT.id);
    }else{
      final doc=db.collection('PostLike').doc(likepostmodel.likeuid +likepostmodel.likeid.toString() );
      await doc.set(likepostmodel.toJSne());
    }
  }

  dislike(id) async {
    await db.collection('PostLike').doc(id).delete();
  }

  bool? islike;
  Future fetchlikedpostpost(id)async{
    final snapshot = await db.collection('PostLike').doc(id).get();
      if(snapshot.exists){
        islike = true;
        return islike;
      }else{
        islike=false;
        return islike;
      }
  }
}
