import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addreview.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/USER/Drawer/shotlist.dart';
import 'package:provider/provider.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final review = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reviews',
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
          // actions: [
          //   IconButton(onPressed: () {
          //                   Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => const Shortlist()));
          //   }, icon: const Icon(Icons.favorite)),
          //   IconButton(onPressed: () {
          //      Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => Chatpage(),
          //         ));
          //   }, icon: const Icon(Icons.chat_outlined))
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Enter your Reviews and   ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                ),
                Row(
                  children: [
                    Text(
                      "Experience !   ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    SizedBox(
                      width: 50,
                    ),

                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Shortlist()));
                        },
                        icon: Icon(
                          Icons.star,
                          color: Color(0xffFFC350),
                        )),

                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Shortlist()));
                        },
                        icon: Icon(
                          Icons.star,
                          color: Color(0xffFFC350),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Shortlist()));
                        },
                        icon: Icon(
                          Icons.star,
                          color: Color(0xffFFC350),
                        )),

                    // Icon(
                    //   Icons.star,
                    //   color: Color(0xffFFC350),
                    // ),

                    // Icon(
                    //   Icons.star,
                    //   color: Color(0xffFFC350),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                    controller: review,
                    maxLines: 3,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: ("           Enter here....."),
                    )),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Consumer<FunctionProvider>(
                      builder: (context, helper, child) {
                        return ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(150, 50)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffFE693A))),
                            onPressed: () {
                              helper.addReview(AddReview(
                                review: review.text,
                                uid: auth.currentUser!.uid,
                              )).then((value){
                                SuccesToast(context, 'Add review succes');
                                claer();
                              });
                            },
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ));
                      },
                    )),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  "   Thank you for your valuable review",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
  claer(){
    review.clear();
  }
}
