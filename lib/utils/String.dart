import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

    final auth = FirebaseAuth.instance;

final db = FirebaseFirestore.instance;

class Helper {
  static double W(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double h(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

SuccesToast(BuildContext context, msg) {
  CherryToast.success(title: Text(msg, style: TextStyle(color: Colors.black)))
      .show(context);
}

Infotoast(BuildContext context, msg) {
  CherryToast.info(
    title: Text(msg, style: TextStyle(color: Colors.black)),
  ).show(context);
}
