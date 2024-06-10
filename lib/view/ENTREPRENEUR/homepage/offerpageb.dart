import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/collection/offer_controller.dart';
import 'package:main_project/model/offer_model.dart';
import 'package:uuid/uuid.dart';

class Enofferpagee extends StatefulWidget {
  const Enofferpagee({super.key});

  @override
  State<Enofferpagee> createState() => _EnofferpageeState();
}

class _EnofferpageeState extends State<Enofferpagee> {
  File? _imageFile;

  Offercontroller offercontroller = Offercontroller();
  final _auth = FirebaseAuth.instance;
  final _imagecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  void _toggleLoading() {
    setState(() {
      isloading = !isloading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Offer Page',
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
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      backgroundColor: const Color(0xffF9F8C9),
      body: SingleChildScrollView(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              const SizedBox(height: 30),
              const Text("Image of product"),
              const SizedBox(height: 7),
              InkWell(
                onTap: () {
                  _showImagePickerBottomSheet(context);
                },
                child: Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffFF4141)),
                  ),
                  onPressed: () async {
                    setState(() {
      isloading = true;
    });
                   await addoffer();
                   setState(() {
      isloading = false;
    });
                    
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 60),
               Center(
                     child: isloading
                         ? CircularProgressIndicator()
                         : Container()
                   ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addoffer() async {
    
    if (_imageFile == null) {
      Fluttertoast.showToast(
        msg: "No image selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    try {
      
      var id = const Uuid().v1();
      String fileExtension = _imageFile!.path.split('.').last;
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('offerImages')
          .child('$id.$fileExtension');

      UploadTask uploadTask = storageRef.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String fileUrl = await taskSnapshot.ref.getDownloadURL();

      Offermodel offermodel = Offermodel(image: fileUrl, id: id);
      await offercontroller.addoffer(offermodel, id);

      setState(() {
        _imageFile = null;
        _imagecontroller.clear();
      });
      

      Fluttertoast.showToast(
        msg: "Post uploaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Upload failed: ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
                leading: const Icon(Icons.camera, color: Colors.indigo),
                title: const Text(
                  'Take a photo',
                  style: TextStyle(color: Colors.indigo),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.indigo),
                title: const Text(
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
}
