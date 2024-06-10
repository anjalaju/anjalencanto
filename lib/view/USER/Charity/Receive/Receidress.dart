import 'package:flutter/material.dart';
import 'package:main_project/view/USER/chat.dart';
import 'package:url_launcher/url_launcher.dart';

class Receivedress extends StatefulWidget {
  const Receivedress({super.key});

  @override
  State<Receivedress> createState() => _ReceivedressState();
}

class _ReceivedressState extends State<Receivedress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dress',
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
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 320,
                  width: 240,
                  // color: Colors.amber,
                  child: Image(
                    image: AssetImage(
                      "images/Dress.jpeg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Fathima"),
              Text("Age : 25"),
              Text("poopalam , perinthalmanna"),
              Text("Number of items : 1"),
              Text("Contact Number : 7994413795"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                const Color(0xffFF004D)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(250, 50)),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Color(0xffFF004D))),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Chatpage(
                              name: 'Dress',
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
                            MaterialStateProperty.all(const Color(0xff63C336)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        minimumSize:
                            MaterialStateProperty.all(const Size(30, 50)),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Color(0xff63C336)),
                        ),
                      ),
                      onPressed: () {
                            _makePhoneCall('7025053483');
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
      ),
    );
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
