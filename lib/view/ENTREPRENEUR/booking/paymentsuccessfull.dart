import 'package:flutter/material.dart';

class Entrepaysuccess extends StatefulWidget {
  const Entrepaysuccess({super.key});

  @override
  State<Entrepaysuccess> createState() => _LogaState();
}

class _LogaState extends State<Entrepaysuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Container(

                    decoration: BoxDecoration(    color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                    height: 400,
                    width: double.infinity,
                  
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadiusDirectional.circular(20))),
                        minimumSize:
                            MaterialStateProperty.all(const Size(300, 50)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xccFF4141))),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder:(context) => loginnotification()));
                    },
                    child: const Text(
                      "Done",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ));
  }
}
