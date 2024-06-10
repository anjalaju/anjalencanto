import 'package:flutter/material.dart';

class EntreSettingchangepass extends StatefulWidget {
  const EntreSettingchangepass({super.key});

  @override
  State<EntreSettingchangepass> createState() => _SettingchangepassState();
}

class _SettingchangepassState extends State<EntreSettingchangepass> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: const Text(
          'Change Password',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
          
          
            children: [
              SizedBox(
                height: 80,
              ),
          
          
               TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ), 
                          hintText: ("         Current Password"),
                          ),
                          
                    ),

                     SizedBox(
                height: 30,
              ),
          
          
               TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ), 
                          hintText: ("        New Password"),
                          ),
                          
                    ),


                     SizedBox(
                height: 30,
              ),
          
          
               TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ), 
                          hintText: ("         Confirm Password"),
                          ),
                          
                    ),


                     const SizedBox(
                  height: 80,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10))),
                            minimumSize: MaterialStateProperty.all(const Size(280, 50)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffE46060))),
                        onPressed: () {
                    
                          // Navigator.push(context, MaterialPageRoute(builder:(context) => loginnotification()));
                        },
                        child: const Text(
                          "Reset",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
     
      
    );
  }
}