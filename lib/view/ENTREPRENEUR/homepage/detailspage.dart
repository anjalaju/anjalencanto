import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/controller/AuthProvider.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Entredetailspage extends StatefulWidget {
  const Entredetailspage({super.key});

  @override
  State<Entredetailspage> createState() => _LogaState();
}

class _LogaState extends State<Entredetailspage> {
  final Eventlist = [
    'Venues',
    'Photograpers',
    'Catering',
    'Planning And Dcro',
    'Jewellery and Accessories',
    'Makeup artist',
    'Bridal wear and accssories',
    'Groom wear and accessories',
    'Rentals',
    'Mehandi artist',
    'Transportation',
    'Gift',
    'Cakes',
    'Music dance',
    'Card makes',
    'Pre wedding shoot',
  ];

  final Map<String, List<String>> subcategory = {
    'Venues': [
      'Banquet halls',
      'Klyana mandapam',
      'Resorts',
      'Small Function/ Part halls',
      '4star &abouve hotels'
    ],
    'Photograpers': [
      'Photographersd',
    ],
    'Catering': [
      'Western Dishes',
      'Nadan Sadhya',
      'hyderabad Dishes',
      'Biriyani Dishes',
      'Other snacks'
    ],
    'Planning And Dcro': [
      'Wedding planeers',
      'Decarotors',
      'Small function Decor'
    ],
    'Jewellery and Accessories': ['Jewellery', 'Accessories'],
    'Makeup artist': ['Bridal Makeup ', 'Groom Makeup'],
    'Bridal wear and accssories': [
      'Bridal lehengas',
      'Kanjeevaram silk sarees',
      'Wedding Gown'
    ],
    'Groom wear and accessories': ['Shervani', 'Wedding suits', 'Kurtha'],
    'Rentals': ['Rental Dress', 'Rental jewelry'],
    'Mehandi artist': ['Mehandhi artist'],
    'Transportation': ['Bus ', 'car', 'traveller'],
    'Gift': ['gifts'],
    'Cakes': ['home made cakes', 'bakery cakes'],
    'Music dance': [
      'Western dance',
      'indian dance',
      'Western music',
      'indian music'
    ],
    'Card makes': ['wedding cards', 'save the date', 'other function cards'],
    'Pre wedding shoot': ['pre wedding photograpers'],
  };
  String? selectedMainCategory;
  String? selectedSubCategory;

  String? producturl;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authprvdr = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details Page',
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
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Bussiness name",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: authprvdr.eventname,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if(value!.isEmpty ){
                        return 'enter value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Place",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    controller: authprvdr.eventplace,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     validator: (value) {
                      if(value!.isEmpty ){
                        return 'enter value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: Eventlist.map((e) {
                      return DropdownMenuItem(
                        value: e.toString(),
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMainCategory = value;
                        selectedSubCategory = null;
                      });
                    },
                    value: selectedMainCategory,
                    hint: const Text('select category'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: selectedMainCategory != null
                        ? subcategory[selectedMainCategory]!.map((e) {
                            return DropdownMenuItem(
                              value: e.toString(),
                              child: Text(e),
                            );
                          }).toList()
                        : [],
                    onChanged: (value) {
                      setState(() {
                        selectedSubCategory = value;
                      });
                    },
                    value: selectedSubCategory,
                    hint: const Text('select subcategory'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Short discription",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    controller: authprvdr.eventdiscription,
                    maxLines: 5,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     validator: (value) {
                      if(value!.isEmpty ){
                        return 'enter value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Starting Price from",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    controller: authprvdr.eventprice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     validator: (value) {
                      if(value!.isEmpty ){
                        return 'enter value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    controller: authprvdr.phonenumber,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      // hintText: 'phonenumber',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     validator: (value) {
                      if(value!.isEmpty ){
                        return 'enter value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Image of product",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(right: 180),
                    child: InkWell(
                      onTap: () {
                        _showImagePickerBottomSheet(context);
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                              15), // Adjust the radius as needed
                        ),
                        child: _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    15), // Adjust the radius as needed
                                child: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : const Icon(
                                Icons.add,
                                size: 40,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(child: Consumer<FunctionProvider>(
                    builder: (context, instance, child) {
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
                                  const Color(0xffFF4141))),
                          onPressed: () async {
                            if(formkey.currentState!.validate()){
                              if (producturl != null &&  selectedMainCategory != null&& selectedSubCategory!= null) {
                              await instance
                                  .setEvent(
                                EventModel(
                                  eventName: authprvdr.eventname.text,
                                  eventPlace: authprvdr.eventplace.text,
                                  eventmainCategory:
                                      selectedMainCategory.toString(),
                                  eventSubcategory:
                                      selectedSubCategory.toString(),
                                  enterprenurid: auth.currentUser!.uid,
                                  Image: producturl.toString(),
                                  discription: authprvdr.eventdiscription.text,
                                  startingPriceFrom: authprvdr.eventprice.text,
                                  phonenumber: authprvdr.phonenumber.text,
                                  uid: auth.currentUser!.uid, 
                                ),
                              )
                                  .then((value) {
                                SuccesToast(context, 'add event succes');
              
                                authprvdr.clearcontrl();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('plase wait ')));
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('add succes ')));
                            }
                          },
                          child: const Text(
                            "Submit",
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
          ),
        ));
  }

  DateTime? selectedDate;

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

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera,
                  color: Colors.indigo,
                ),
                title: const Text(
                  'Take a photo',
                  style: TextStyle(color: Colors.indigo),
                ),
                onTap: () async {
                  await _pickImage(ImageSource.camera).then((value) async {
                    SettableMetadata metadata =
                        SettableMetadata(contentType: 'image/jpeg');
                    final currenttime = TimeOfDay.now();
                    UploadTask uploadTask = FirebaseStorage.instance
                        .ref()
                        .child('eventimage/$currenttime')
                        .putFile(_imageFile!, metadata);
                    TaskSnapshot snapshot = await uploadTask;
                    await snapshot.ref.getDownloadURL().then((value) {
                      setState(() {
                        producturl = value;
                         Navigator.pop(context);
                      });
                    });
                  });
                 
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.indigo),
                title: const Text(
                  'Choose from gallery',
                  style: TextStyle(color: Colors.indigo),
                ),
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
                    await snapshot.ref.getDownloadURL().then((value) {
                      setState(() {
                        producturl = value;
                      });
                    });
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
