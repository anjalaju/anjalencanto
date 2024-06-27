import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/enterprenurmodel.dart';
import 'package:main_project/view/ENTREPRENEUR/formscreen/loginnotifi.dart';

import 'package:main_project/view/ENTREPRENEUR/formscreen/otppage/successfull.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  bool obscuretext = false;

  toggile() {
    obscuretext = !obscuretext;
  }

  clearcontrl() {
    enteremail.clear();
    enterpassword.clear();
    eventname.clear();
    eventplace.clear();
    eventdiscription.clear();
    eventprice.clear();
    phonenumber.clear();
    notifyListeners();
  }

  //enterprenur
  final entername = TextEditingController();
  final enternumber = TextEditingController();
  final enteremail = TextEditingController();
  final enterpassword = TextEditingController();

  //addevent

  final eventname = TextEditingController();
  final eventplace = TextEditingController();
  final eventdiscription = TextEditingController();
  final eventprice = TextEditingController();
  final phonenumber = TextEditingController();

  Future SignupEnterprenur(BuildContext context, email, password) async {
    try {
      final instance = Provider.of<FunctionProvider>(context, listen: false);
      final functionprovider =
          Provider.of<AuthProvider>(context, listen: false);

      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await instance.addEnterprenur(
            EnterprenurModel(
                entrepreneurName: functionprovider.entername.text,
                entrepreneurNumber: functionprovider.enternumber.text,
                entrepreneurEmail: functionprovider.enteremail.text,
                entrepreneurPassword: functionprovider.enterpassword.text,
                image: '',
                businessName: '',
                location: '',
                uid: value.user!.uid,
                userType: 'enterprenur',
                timestamp: DateTime.now()),
            value.user!.uid);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Entresuccessfull()),
          (route) => false,
        );
       

        clearcontrl();
         functionprovider.entername.clear();
         functionprovider.enternumber.clear();
      });
    } on FirebaseException catch (e) {
      Infotoast(context, 'Error ');
    }
  }

  // Future<void> signin(email, password, BuildContext context) async {
  //   try {

  //   final UserCredential userCredential=  auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((value)async {

  //     final uid =   value.user!.uid;
  //       final snapshot = await  db.collection('enterprenur')

  //       .where('userType',isEqualTo: 'enterprenur').get();

  //       if(snapshot.docs.isNotEmpty){
  //         Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Entreloginnotification(),
  //         ),
  //       );
  //       }else{
  //         Infotoast(context, 'check mail');
  //       }

  //       SuccesToast(context, 'Loggin succes');
  //       clearcontrl();
  //     });
  //   } on FirebaseException catch (e) {
  //     Infotoast(context, 'error loggin');
  //   }
  // }

  Future<void> signin(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;
      final snapshot =
          await db.collection('enterprenur').where('uid', isEqualTo: uid).get();

      if (snapshot.docs.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Entreloginnotification(),
          ),
        );
        SuccesToast(context, 'Login success');
        clearcontrl();
      } else {
        Infotoast(context, 'User not found');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Infotoast(context, 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        Infotoast(context, 'Wrong password provided for that user');
      } else {
        Infotoast(context, 'Error signing in');
      }
    } catch (e) {
      print(e.toString());
      Infotoast(context, 'Error signing in');
    }
  }

  Future logoutevent(BuildContext context) async {
    try {
      await auth.signOut();
    } on FirebaseException catch (e) {
      Infotoast(context, 'logout succes');
    }
  }
}
