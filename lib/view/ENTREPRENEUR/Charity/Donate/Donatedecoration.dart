import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



// class EntreDonatedecoration extends StatefulWidget {
  

// class Donatedecoration extends StatefulWidget {
 import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/Donatemodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class EntreDonatedecoration extends StatefulWidget {
  const EntreDonatedecoration({super.key});

  @override
  State<EntreDonatedecoration> createState() => _LogaState();
}

class _LogaState extends State<EntreDonatedecoration> {
  final name = TextEditingController();
  final age = TextEditingController();

  final itemname = TextEditingController();
  final contactnumber = TextEditingController();
  final placeame = TextEditingController();

  final numberofitem = TextEditingController();

  final form = GlobalKey<FormState>();

  final selectedvalue = 'Decorationitems';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donate Dress',
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
          child: Form(
            key: form,
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
                const Text("Name and surname"),
                const SizedBox(height: 7),
                TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Age"),
                const SizedBox(height: 7),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Item name"),
                const SizedBox(height: 7),
                TextFormField(
                  controller: itemname,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("Image of product"),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: InkWell(
                    onTap: () {
                      // _showImagePickerBottomSheet(context);
                      provider.imagePicker();
                    },
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the radius as needed
                      ),
                      child: provider.selectedimage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15), // Adjust the radius as needed
                              child: Image.file(
                                provider.selectedimage!,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Icon(
                              Icons.add,
                              size: 40,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Contact number"),
                const SizedBox(height: 7),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  controller: contactnumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("place"),
                const SizedBox(height: 7),
                TextFormField(
                  controller: placeame,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Number of items"),
                const SizedBox(height: 7),
                TextFormField(
                  controller: numberofitem,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: Helper.h(context) * .050,
                ),
                Center(child: Consumer<FunctionProvider>(
                  builder: (context, helper, child) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(const Size(300, 50)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xccFF4141))),
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            if (provider.url != null) {
                              helper
                                  .addDonate(
                                    Donatemodel(
                                      name: name.text,
                                      age: age.text,
                                      itemname: itemname.text,
                                      image: helper.url.toString(),
                                      contactnumber: contactnumber.text,
                                      place: placeame.text,
                                      numberofitem: numberofitem.text,
                                      selected: selectedvalue,
                                         uid: auth.currentUser!.uid,
                                    ),
                                  )
                                  .then(
                                    (value) => {
                                      clear(),
                                      provider.clearcontrooler(),
                                      SuccesToast(context, 'Add Donate Succes'),
                                    },
                                  );

                              log('add then clear check ${provider.url}============================================================');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Add image')));
                            }
                          }
                        },
                        child: const Text(
                          "Send",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ));
                  },
                )),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera,
                  color: Colors.indigo,
                ),
                title: Text(
                  'Take a photo',
                  style: TextStyle(color: Colors.indigo),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.indigo),
                title: Text(
                  'Choose from gallery',
                  style: TextStyle(color: Colors.indigo),
                ),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  clear() {
    name.clear();
    age.clear();
    itemname.clear();
    itemname.clear();
    contactnumber.clear();
    placeame.clear();
    placeame.clear();
    numberofitem.clear();
  }
}
