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
    return Scaffold(body: Consumer<FunctionProvider>(
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

            return GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: Helper.W(context) * .030,
                mainAxisSpacing: Helper.W(context) * .030,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Material(
                      elevation: 4,
                      child: Container(
                        width: Helper.W(context) * .50,
                        // height: Helper.h(context) * .110,
                        color: const Color.fromRGBO(245, 245, 245, 1),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Helper.h(context) * .020,
                            ),
                            Container(
                              width: Helper.W(context) * .050,
                              height: Helper.h(context) * .20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(list[index].Image),
                              )),
                            ),
                            SizedBox(
                              height: Helper.h(context) * .010,
                            ),
                            Text(' EVENT NAME :${list[index].eventName}'),
                            Text(' CONTACT NUMBER :${list[index].phonenumber}'),
                            Text(
                                'EVENT CATEGORY :${list[index].eventmainCategory}'),
                            Text(
                                'EVENT SBCATEGORY :${list[index].eventSubcategory}'),
                            Text('Place :${list[index].eventPlace}'),
                            Text('Driscription :${list[index].discription}'),
                            SizedBox(
                              height: Helper.h(context) * .010,
                            ),
                            Text('PRICE :${list[index].startingPriceFrom}'),
                          ],
                        ),
                      ),
                    ),
                
                  Positioned(
                    left: Helper.W(context)*.20,
                    child: IconButton(onPressed: (){
                      db.collection('AddEvent').doc(list[index].id).delete();
                    }, icon: Icon(Icons.delete)))
                    ],
                );
              },
            );
          },
        );
      },
    ));
  }
}
