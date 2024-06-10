import 'package:flutter/material.dart';

class Shortlistphotographer extends StatefulWidget {
  const Shortlistphotographer({super.key});

  @override
  State<Shortlistphotographer> createState() => _ShortlistphotographerState();
}

class _ShortlistphotographerState extends State<Shortlistphotographer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shortlist',
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
      //   actions: [
      //     IconButton(onPressed: () {
      //       Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => Shortlist()),
      // );
      //     }, icon: const Icon(Icons.favorite)),
      //     IconButton(onPressed: () {
      //       Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => Chatpage()),
      // );
      //     }, icon: const Icon(Icons.chat_outlined))
      //   ],
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: const Image(
                          image: AssetImage(
                            "images/photographers.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("kanjirampara , ucharakkadavu"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("photomax studioz"),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("photo+video"),
                            ],
                          ),
                          Text("8000 "),
                          Text("per day")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      const Color(0xffFF004D)),
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(250, 50)),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: Color(0xffFF004D))),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)))),
                              onPressed: () {
      //                           Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => Chatpage()),
      // );
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.message),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Message"),
                                ],
                              )),
                          OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  const Color(0xff63C336)),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(100, 50)),
                              shape: MaterialStateProperty.all(
                                const CircleBorder(),
                              ),
                              side: MaterialStateProperty.all(
                                const BorderSide(color: Color(0xff63C336)),
                              ),
                            ),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(Icons.call),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
