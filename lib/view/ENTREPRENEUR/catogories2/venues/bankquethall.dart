import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/view/ENTREPRENEUR/Entrechat.dart';
import 'package:main_project/view/USER/events/eventpage.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Entrepbankquet extends StatefulWidget {
  const Entrepbankquet({super.key});

  @override
  State<Entrepbankquet> createState() => _EntrepbankquetState();
}

class _EntrepbankquetState extends State<Entrepbankquet> {
 

  // edit

  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {}
  }

  String? producturl;

  // bootm sheet update
  Future editbootmsheet(EventModel eventModel) async {
    editname.text = eventModel.eventName;
    editplace.text = eventModel.eventPlace;
    discription.text = eventModel.discription;
    price.text = eventModel.startingPriceFrom;

    await showModalBottomSheet<void>(
      enableDrag: true,
      scrollControlDisabledMaxHeightRatio: 5,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 700,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: Helper.h(context) * .10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _pickImage(ImageSource.gallery).then((value) async {
                        SettableMetadata metadata =
                            SettableMetadata(contentType: 'image/jpeg');
                        final currenttime = TimeOfDay.now();
                        UploadTask uploadTask = FirebaseStorage.instance
                            .ref()
                            .child('eventimage/$currenttime')
                            .putFile(_imageFile!, metadata);
                        TaskSnapshot snapshot = await uploadTask;
                        producturl = await snapshot.ref.getDownloadURL();
                      });
                    },
                    child: Container(
                      width: Helper.W(context) * .50,
                      height: Helper.h(context) * .20,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(eventModel.Image),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Helper.h(context) * .020,
              ),
              SizedBox(
                width: Helper.W(context) * .50,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: editname,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: Helper.h(context) * .020,
              ),
              SizedBox(
                width: Helper.W(context) * .50,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: price,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: Helper.h(context) * .020,
              ),
              SizedBox(
                width: Helper.W(context) * .50,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: editplace,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: Helper.h(context) * .020,
              ),
              SizedBox(
                width: Helper.W(context) * .50,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: discription,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: Helper.h(context) * .020,
              ),
              Consumer<FunctionProvider>(
                builder: (context, instance, child) {
                  return GestureDetector(
                    onTap: () async {
                      // if (producturl != null) {
                        await instance
                            .updateevent(
                          eventModel.id,
                          editname.text,
                          price.text,
                          editplace.text,
                          discription.text,
                          producturl,
                        )
                            .then((value) {
                          SuccesToast(context, 'update succes');
                          setState(() {});
                          Navigator.pop(context);
                        });

                        
                      // }
                      //  else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please wait')));
                      // }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Helper.W(context) * .40,
                      height: Helper.h(context) * .050,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: const Text('Update '),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog(EventModel eventModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete event'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Are you sure delete'),
                Text(eventModel.eventName)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('no'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            Consumer<FunctionProvider>(
              builder: (context, instance, child) {
                return TextButton(
                  child: const Text('conform'),
                  onPressed: () async {
                    await instance.deletedoc(eventModel.id).then((value) {
                      SuccesToast(context, 'succes delete event');
                      Navigator.pop(context);
                    });
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  final editname = TextEditingController();
  final editplace = TextEditingController();

  final discription = TextEditingController();

  final price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Banquet Halls',
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
        body: Consumer<FunctionProvider>(
          builder: (context, instance, child) {
            return StreamBuilder(
              stream: instance.getEventproject('Venues', 'Banquet halls'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<EventModel> list = [];
                list = snapshot.data!.docs.map((e) {
                  return EventModel.fromJsone(e.data() as Map<String, dynamic>);
                }).toList();
                if (snapshot.hasData) {
                  return list.isEmpty
                      ? Center(
                          child: Text('no data'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                fillColor: const Color(0xffD9D9D9),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: ("  Search Venues..."),
                                prefixIcon: const Icon(Icons.search),
                              ),
                            ),
                            ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {


                                    log('the data index doc ${list[index].id}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 231,
                                          width: 350,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: list[index].Image.isEmpty
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Image(
                                                  image: NetworkImage(
                                                    list[index].Image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(list[index].eventName),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(list[index].eventPlace),
                                                  IconButton(


                                                      onPressed: () async {
                                                        await _showMyDialog(
                                                          list[index],
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(list[index].discription),
                                                  IconButton(

                                                    
                                                      onPressed: () {
                                                        editbootmsheet(
                                                            list[index]);
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.currency_rupee,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    list[index]
                                                        .startingPriceFrom,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              // Text("500-700 max")
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                  style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty.all(
                                                              const Color(
                                                                  0xffFF004D)),
                                                      textStyle:
                                                          MaterialStateProperty.all(
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14)),
                                                      minimumSize: MaterialStateProperty.all(
                                                          const Size(250, 50)),
                                                      side: MaterialStateProperty.all(
                                                          const BorderSide(
                                                              color:
                                                                  Color(0xffFF004D))),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          EntreChatpage(
                                                        name: 'Banquet Halls',
                                                      ),
                                                    ));
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.message),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text("Message"),
                                                    ],
                                                  )),
                                              OutlinedButton(
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xff63C336)),
                                                  textStyle:
                                                      MaterialStateProperty.all(
                                                    const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          const Size(30, 50)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const CircleBorder(),
                                                  ),
                                                  side:
                                                      MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color:
                                                            Color(0xff63C336)),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _makePhoneCall(
                                                      list[index].phonenumber);
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.call),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 40,
                                );
                              },
                            ),
                          ],
                        ));
                }
                return Container();
              },
            );
          },
        ));
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
