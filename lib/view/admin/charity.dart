import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/Donatemodel.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class CharityAdmin extends StatelessWidget {
  const CharityAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<FunctionProvider>(
      builder: (context, helper, child) {
        return StreamBuilder(
          stream: helper.getallcharity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<Donatemodel> list = [];

            list = snapshot.data!.docs.map((e) {
              return Donatemodel.fromjsone(e.data() as Map<String, dynamic>);
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
                                image: NetworkImage(list[index].image),
                              )),
                            ),
                            SizedBox(
                              height: Helper.h(context) * .010,
                            ),
                            Text('   NAME :${list[index].itemname}'),
                            Text(' DONATED BY NAME :${list[index].name}'),


                            Text(' NUMBER ITEMS :${list[index].numberofitem}'),
                            Text(
                                'PLACE :${list[index].place}'),
                            Text(
                                'DONATED CATEGORY :${list[index].selected}'),
                             
                            SizedBox(
                              height: Helper.h(context) * .010,
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                
                  Positioned(
                    left: Helper.W(context)*.20,
                    child: IconButton(onPressed: (){
                      db.collection('Donatescreen').doc(list[index].id).delete();
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
