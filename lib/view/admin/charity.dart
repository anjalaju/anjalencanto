import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/Donatemodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class CharityAdmin extends StatelessWidget {
  const CharityAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffE72245),
          title: const Text(
            'Charity list',
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
              stream: helper.getallcharity(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<Donatemodel> list = [];

                list = snapshot.data!.docs.map((e) {
                  return Donatemodel.fromjsone(
                      e.data() as Map<String, dynamic>);
                }).toList();

                list.shuffle();

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: Helper.W(context) * .030,
                      mainAxisSpacing: Helper.W(context) * .030,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff850F8D),
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
                                                .collection('Donatescreen')
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
                                      height: Helper.h(context) * .125,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(list[index].image),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Helper.h(context) * .010,
                                  ),
                                  Text(
                                    ' Item Name: ${list[index].itemname}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(' Donated by: ${list[index].name}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Text(
                                      ' No of Items: ${list[index].numberofitem}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Text(' Place: ${list[index].place}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Text(
                                      ' Category: ${list[index].selected}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  SizedBox(
                                    height: Helper.h(context) * .010,
                                  ),
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
