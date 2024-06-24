import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:main_project/view/USER/booking/payment.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/model/userbookingmodel.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Bookimgpage extends StatefulWidget {
  EventModel eventModel;
  Bookimgpage({super.key, required this.eventModel});

  @override
  State<Bookimgpage> createState() => _LogaState();
}

class _LogaState extends State<Bookimgpage> {

  DateTime selecdate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final functionprovider = Provider.of<FunctionProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Booking',
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
        backgroundColor: Color(0xffF9F8C9),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Details",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Name"),
                const SizedBox(height: 7),
                TextField(
                  controller: functionprovider.bookingname,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Email"),
                const SizedBox(height: 7),
                TextField(
                  controller: functionprovider.bookemail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Phone number"),
                const SizedBox(height: 7),
                TextField(
                  controller: functionprovider.bookphonenumber,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: TextField( textAlign: TextAlign.center,
                //         decoration: InputDecoration(
                //           hintText: 'Date',
                //           fillColor: Colors.white,
                //           filled: true,
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 7),
                //     Expanded(
                //       child: TextField(textAlign: TextAlign.center,
                //         decoration: InputDecoration(
                //           hintText: 'Month',
                //           fillColor: Colors.white,
                //           filled: true,
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 90),
                //   child: TextField(textAlign: TextAlign.center,
                //     decoration: InputDecoration(
                //       hintText: '  Year',
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 30,
                ),
                // TextField(
                //   readOnly: true,
                //   onTap: () {
                //     _selectDate(context);
                //   },
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(Icons.calendar_today),
                //     hintText: selectedDate != null
                //         ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
                //         : 'Select Date',
                //     fillColor: Colors.white,
                //     filled: true,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                // ),
                TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                                // filled: true,
                                hintText: selecdate != null
                                    ? "${selecdate!.day}/${selecdate!.month}/${selecdate!.year}"
                                    : "Date",
                                // hintText: " Name",
                                // prefixIcon: Icon(Icons.person),
                                // fillColor: Color(0xFFF3EEEE),
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      final DateTime? date =
                                          await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(3000));

                                      if (selecdate != null) {
                                        setState(() {
                                          selecdate = date!;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.date_range))),
                          ),
                SizedBox(height: 10),
                Text("Small Discription"),
                TextField(
                  controller: functionprovider.bookdiscription,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20))),
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 50)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xccFF4141))),
                      onPressed: () {
                      final formatdate=  DateFormat('dd-MM-yyyy').format(selecdate);
                        if (selectedDate != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Payment(
                                bookingModle: BookingModle(
                                  name: functionprovider.bookingname.text,
                                  email: functionprovider.bookemail.text,
                                  phonenumber:
                                      functionprovider.bookphonenumber.text,
                                  date: formatdate,
                                  discription:
                                      functionprovider.bookdiscription.text,
                                  eventid: widget.eventModel!.id.toString(),
                                  userid: auth.currentUser!.uid,
                                  paymentstatus: 'Pending',
                                  eventprice:
                                      widget.eventModel!.startingPriceFrom,
                                ),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('select data time')));
                        }
                      },
                      child: const Text(
                        "Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ));
  }

  DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
