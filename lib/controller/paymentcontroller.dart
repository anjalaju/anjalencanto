

import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class PaymentController with ChangeNotifier{

  UpiIndia upiIndia = UpiIndia();
  UpiApp app =UpiApp.googlePay;

  Future<UpiApp> appopen()async{
    return UpiApp.googlePay;
  }


 Future<UpiResponse> initiateTransaction(
  // UpiApp app
  {required double amout,
  required String recivername,
  }
  ) async {
    return upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9078600498@ybl",
      receiverName: recivername,
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: amout,
    );
  }
  
}