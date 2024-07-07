import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/view/USER/booking/paymentsuccessfull.dart';
import 'package:main_project/model/userbookingmodel.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/controller/paymentcontroller.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';

class Payment extends StatefulWidget {
  BookingModle bookingModle;
  Payment({super.key, required this.bookingModle});

  @override
  State<Payment> createState() => _LogaState();
}

class _LogaState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final amoutcontroler =
        TextEditingController(text: widget.bookingModle.eventprice);

    final name = TextEditingController(text: widget.bookingModle.name);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          backgroundColor: Colors.transparent,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              thickness: 2,
              color: Colors.black,
              height: 1,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xffF9F8C9),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    "Payment",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Center(
                //     child: Container(
                //   height: 150,
                //   child: Image(
                //     image: AssetImage(
                //       "images/Gpayphoto.png",
                //     ),
                //     fit: BoxFit.cover,
                //   ),
                // )),

                FutureBuilder(
                  future: PaymentController().appopen(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/gpay.png'),
                          ),
                          title: Text(snapshot.data!.name),
                          onTap: () {
                            PaymentController().initiateTransaction(
                                amout: 10, recivername: 'anjal');
                          },
                        );
                      },
                    );
                  },
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 50),
                    hintText: '  To ......',
                    hintStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: amoutcontroler,
                        style: TextStyle(fontSize: 30),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 20),
                            prefixIcon: Icon(
                              Icons.currency_rupee,
                              size: 35,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                Center(child: Consumer<FunctionProvider>(
                  builder: (context, helper, child) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20))),
                            minimumSize:
                                MaterialStateProperty.all(const Size(300, 50)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xccFF4141))),
                        onPressed: () async {
                          await helper
                              .bookingEvent(context,
                            BookingModle(
                                enterprenurid:
                                    widget.bookingModle.enterprenurid,
                                name: widget.bookingModle.name,
                                email: widget.bookingModle.email,
                                phonenumber: widget.bookingModle.phonenumber,
                                date: widget.bookingModle.date.toString(),
                                discription: widget.bookingModle.discription,
                                eventid: widget.bookingModle.eventid,
                                userid: widget.bookingModle.userid,
                                paymentstatus: 'succes',
                                eventprice: widget.bookingModle.eventprice),
                          )
                              .then((value) {
                            SuccesToast(context, 'succes');
                            helper.clear();
                          });
                          await PaymentController()
                              .appopen()
                              .then((value) async {
                            var transaction = await PaymentController()
                                .initiateTransaction(
                                    amout: 10,
                                    recivername: widget.bookingModle.name)
                                .then((value) {
                              final statu =
                                  value.status == UpiPaymentStatus.SUCCESS;
                            });
                          });

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Paymentsuccessfull(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Proceed to pay",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ));
                  },
                )),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ));
  }

//   if (snapshot.hasError) {
//   switch (snapshot.error.runtimeType) {
//     case UpiIndiaAppNotInstalledException:
//       print("Requested app not installed on device");
//       break;
//     case UpiIndiaUserCancelledException:
//       print("You cancelled the transaction");
//       break;
//     case UpiIndiaNullResponseException:
//       print("Requested app didn't return any response");
//       break;
//     case UpiIndiaInvalidParametersException:
//       print("Requested app cannot handle the transaction");
//       break;
//     default:
//       print("An Unknown error has occurred");
//       break;
//   }
// }
}
