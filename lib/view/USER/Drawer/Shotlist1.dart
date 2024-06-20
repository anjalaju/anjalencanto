import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/USER/homepage/bottomnav.dart';
import 'package:main_project/view/USER/homepage/homepage.dart';
import 'package:provider/provider.dart';

class Shortlistphotographer extends StatefulWidget {
  EventModel eventModel;
  Shortlistphotographer({super.key, required this.eventModel});

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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.eventModel.Image,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.eventModel.eventName),
                              Consumer<FunctionProvider>(
                                builder: (context, helper, child) {
                                  return IconButton(
                                      onPressed: () async {
                                        helper.deletePostLike(
                                            widget.eventModel.id.toString(),
                                            context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  bottomnavipage(
                                                indexnum: 0,
                                              ),
                                            ));
                                      },
                                      icon: const Icon(Icons.delete));
                                },
                              )
                            ],
                          ),
                          Text(widget.eventModel.eventPlace),

                          Text(widget.eventModel.discription),

                          Row(
                            children: [
                              const Icon(Icons.currency_rupee),
                              Text(' ${widget.eventModel.startingPriceFrom}',style: const TextStyle(fontWeight:FontWeight.w900),),
                            ],
                          ),

                          // Text(widget.eventModel.id.toString())
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
