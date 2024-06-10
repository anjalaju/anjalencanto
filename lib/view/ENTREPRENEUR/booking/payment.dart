import 'package:flutter/material.dart';


class Entrepaymentpage extends StatefulWidget {
  const Entrepaymentpage({super.key});

  @override
  State<Entrepaymentpage> createState() => _LogaState();
}

class _LogaState extends State<Entrepaymentpage> {
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 30,),
                const Center(
                  child: Text(
                    "Payment",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),



Center(child: Container(height: 150,
  child:  Image(
                    image: AssetImage(
                      "images/Gpayphoto.png",
                    ),
                    fit: BoxFit.cover,
                  ),)),

           
                TextField(
                  decoration: InputDecoration(contentPadding: const EdgeInsets.only(left: 50),
                         hintText: '  To ......',hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            const SizedBox(height: 30,
            ),
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(height: 200,
                  decoration: BoxDecoration(color: Colors.white,
                     borderRadius: BorderRadius.circular(20),),
                    child: const Center(
                      child: TextField(
                        
                        style: TextStyle(fontSize: 30),keyboardType: TextInputType.number,
                        decoration: InputDecoration( hintStyle: TextStyle(fontSize: 20),
                          prefixIcon: Icon(Icons.currency_rupee,size: 35,),
                          fillColor: Colors.white,
                          filled: true,
                          border:InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                              MaterialStateProperty.all(const Color(0xccFF4141))),
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder:(context) => loginnotification()));
                      },
                      child: const Text(
                        "Proceed to pay",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ));
  }
}
