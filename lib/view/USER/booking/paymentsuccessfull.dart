import 'package:flutter/material.dart';

class Paymentsuccessfull extends StatefulWidget {
  const Paymentsuccessfull({super.key});

  @override
  State<Paymentsuccessfull> createState() => _LogaState();
}

class _LogaState extends State<Paymentsuccessfull> {
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
            children: [
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  height: 400,
                  width: double.infinity,
                 child:Column(
                  children: [
                    SizedBox(height: 50,),
                     Center(
                   child: Container(
                    height: 150,
                    width: 200,
                    // color: Colors.red,
                       child: const Image(
                  image: AssetImage(
                    "images/greenverifi.png",
                  ),
                  fit: BoxFit.cover,
                ),
                   ),
                 ),
                 SizedBox(height: 30,),
                 Text("Your booking is successfully ",style: TextStyle(fontSize: 21),),
                 Text(" completed",style: TextStyle(fontSize: 21)),
                  ],
                 )
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
