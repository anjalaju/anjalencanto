import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class EventViewAdmin extends StatelessWidget {
  const EventViewAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE72245),
          title: const Text(
            'Events list',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          // backgroundColor: Colors.transparent,
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
        // backgroundColor: Colors.black,
        body: Consumer<FunctionProvider>(
          builder: (context, helper, child) {
            return StreamBuilder(
              stream: helper.getAllEvent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<EventModel> list = [];

                list = snapshot.data!.docs.map((e) {
                  return EventModel.fromJsone(e.data() as Map<String, dynamic>);
                }).toList();

                list.shuffle();

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: Helper.W(context) * .030,
                        mainAxisSpacing: Helper.W(context) * .030,
                        childAspectRatio: 0.9),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffA0153E),
                                  borderRadius: BorderRadius.circular(20)),
                              width: Helper.W(context) * .50,
                              // height: Helper.h(context) * .110,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Helper.h(context) * .020,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            db
                                                .collection('AddEvent')
                                                .doc(list[index].id)
                                                .delete();
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 35,
                                              width: 35,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Center(
                                    child: Container(
                                      width: Helper.W(context) * .050,
                                      height: Helper.h(context) * .080,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(list[index].Image),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Helper.h(context) * .010,
                                  ),
                                  Text(
                                    ' Event Name: ${list[index].eventName}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  Text(
                                    ' Phone No: ${list[index].phonenumber}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  Text(
                                    ' Category: ${list[index].eventmainCategory}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  Text(
                                    ' SubCategory: ${list[index].eventSubcategory}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  Text(
                                    ' Place: ${list[index].eventPlace}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  Text(
                                    ' Discription: ${list[index].discription}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  Text(
                                    ' Price: ${list[index].startingPriceFrom}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  // SizedBox(
                                  //   height: Helper.h(context) * .010,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
