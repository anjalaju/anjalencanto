import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/model/Donatemodel.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/model/addreview.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/model/enterprenurmodel.dart';
import 'package:main_project/model/feedback_Review.dart';
import 'package:main_project/model/likepostmodel.dart';
import 'package:main_project/model/notificationmodel.dart';
import 'package:main_project/model/userbookingmodel.dart';
import 'package:main_project/utils/String.dart';

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

  //------------------------set-----------------------------

  Future addEnterprenur(EnterprenurModel enterprenurModel, uid) async {
    final snapshot = db.collection('enterprenur').doc(uid);

    snapshot.set(enterprenurModel.toJsone(snapshot.id));
  }

  Future setEvent(EventModel eventModel) async {
    final snapshot = db.collection('AddEvent').doc();

    snapshot.set(eventModel.toJson(snapshot.id));
  }


  Future addDonate(Donatemodel donate)async{
    final snapshot = db.collection('Donatescreen').doc();

     snapshot.set(donate.tojasone(snapshot.id));
  }

  //------------------------get------------------------

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

   List<Donatemodel> donted=[];
   Future getallDonated(selected)async{
     final snapshot=await  db.collection('Donatescreen').where('Selected',isEqualTo: selected).get();

     donted = snapshot.docs.map((e){
      return Donatemodel.fromjsone(e.data());
     }).toList();
   notifyListeners();
    // donted= snapshot .map((e) { 
    //   return Donatemodel.fromjsone()
    //  }).toList();
   }






   Stream<QuerySnapshot>  getAllEvent(){
    return db.collection('AddEvent').snapshots();
    
   }
  
   List<EventModel> eventsearc=[];
    Future  getAlleventsearch()async{

      final snapshot =await db.collection('AddEvent').get();

      eventsearc =  snapshot.docs.map((e){
        return   EventModel.fromJsone(e.data());
        }).toList();
// notifyListeners();
    }
  


    
    List<EventModel> searchevent=[];

    searcheven(String searchkey){
      searchevent = List.from(eventsearc);
      searchevent = eventsearc.where((element)=> 
           element.eventPlace.toLowerCase().contains(searchkey.toLowerCase())
      ).toList();
      notifyListeners();
    }



    void clearSearchEvent() {
    searchevent.clear();
    notifyListeners();
  }



 


   Stream<QuerySnapshot> getallcharity(){
    return db.collection('Donatescreen').snapshots();
   }


   Stream<QuerySnapshot> getReviewuser(docid){
     return db.collection('AddEvent').doc(docid).collection('FeedbackReview').snapshots();
   }

 Future<void> deleteReview(String docid, String reviewId) async {
    try {
      await db
          .collection('AddEvent')
          .doc(docid)
          .collection('FeedbackReview')
          .doc(reviewId)
          .delete();
    } catch (e) {
      print("Error deleting review: $e");
    }
  }

  //------------------------ update------------------------

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
     notifyListeners();
  }

  ///------------------------delete------------------------

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

    snapshot.set(complaintModel.tojsone(snapshot.id,));
  }

  // Stream<QuerySnapshot> getAllcomplaint() {
  //   return db.collection('Alert').snapshots();
  // }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllcomplaint() {
    return FirebaseFirestore.instance.collection('Alert').snapshots();
  }
  Future addReview(AddReview addReview) async {
    final snapshot =   db.collection('AddReview').doc();

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
        return NotificationModel.fromjsone(e.data()  );
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
          EnterprenurModel.fromJsone(snapshot.data() as Map<String, dynamic>);
    }
  }

  Future likepost(Likepostmodel likepostmodel, id) async {
    final SNAPSHOT = await db.collection('PostLike').doc(id).get();

    if (SNAPSHOT.exists) {
      dislike (SNAPSHOT.id);
    }else{
      final doc=db.collection('PostLike').doc(likepostmodel.likeuid +likepostmodel.likeid.toString() );
      await doc.set(likepostmodel.toJSne());
    }
    notifyListeners();
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


  clearcontrooler(){
    selectedimage=null;
    url=null;
    notifyListeners();
  }
 

 Stream<QuerySnapshot>  getpostlike(uid){
  return db.collection('PostLike').where('likeuid',isEqualTo: uid).snapshots();
  
  
 }

  Future addReviewFeedback(FeedbackReview feedbackreview,pddocid)async{
    final snapshot=  db.collection('AddEvent').doc(pddocid).collection('FeedbackReview').doc();

    snapshot.set(feedbackreview.tojsone(snapshot.id));

  }  


  // Stream get








  ///delete======================================
   

     
Future deletePostLike(String postId,BuildContext context) async {
  try {
     
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('PostLike')
        .where('postid', isEqualTo: postId)
        .get();

    
    if (querySnapshot.docs.isNotEmpty) {
       
      await querySnapshot.docs.first.reference.delete();

      SuccesToast(context, 'Remove fav');
    }
  } catch (e) {
    
    print('Error deleting post like: $e');
  }
}


  String? rating;
  void starCound(rating){
       rating = 
       rating;
       notifyListeners();
  }



  // searching 

    List<EventModel>searchmodel=[];
   
List<EventModel> list = [];

           
    
    List<EventModel> eventfull=[];
    Future  searcheventt()async{
      
     final snapshot=await  db.collection('AddEvent').get();

     eventfull= snapshot.docs.map((e){
        return EventModel.fromJsone(e.data());
      },).toList();
     log('${eventfull.length}');
   }


  //  List<EventModel>
    
}



//  list = snapshot.docs.map((e) {
      //         return EventModel.fromJsone(e.data() as Map<String, dynamic>);
      //       }).toList();
