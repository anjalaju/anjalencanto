

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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
      final instance = Provider.of<FunctionProvider>(context,listen: false);
      final functionprovider = Provider.of<AuthProvider>(context,listen: false);

      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await instance.addEnterprenur(
          EnterprenurModel(
            EnterprenurName: functionprovider.entername.text,
            EnterprenurNumber: functionprovider.enternumber.text,
            EnterprenurEmail: functionprovider.enteremail.text,
            EnterprenurPassword: functionprovider.enterpassword.text,
            image: '',
            businesname: '',
            location: '',
            uid: value.user!.uid,
          ),
          value.user!.uid
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Entresuccessfull()),
          (route) => false,
        );
        clearcontrl();
      });
    } on FirebaseException catch (e) {
      Infotoast(context, 'Error ');
    }
  }

  Future signin(email, password, BuildContext context) async {
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Entreloginnotification(),
          ),
        );
        SuccesToast(context, 'Loggin succes');
        clearcontrl();
      });
    } on FirebaseException catch (e) {
      Infotoast(context, 'error loggin');
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
