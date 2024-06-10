import 'package:flutter/material.dart';
import 'package:main_project/model/complaint.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Entrecomplaint extends StatefulWidget {
  const Entrecomplaint({super.key});

  @override
  State<Entrecomplaint> createState() => _EntrecomplaintState();
}

class _EntrecomplaintState extends State<Entrecomplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complaints',
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: Helper.h(context)*.050,
              ),
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getAllcomplaint(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      
                      List<ComplaintModel>list=[];

                      list= snapshot.data!.docs.map((e) {
                        return ComplaintModel.fromjsone(e.data()as Map<String,dynamic>);
                      }).toList();

                      if(snapshot.hasData){
                        return list.isEmpty?
                        Center(child: Text('No alert '),)
                        :
                        ListView.separated(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 119,
                            width: 373,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 199, 194, 179),
                            ),
                            child:   Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                list[index].complaint,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 30,
                          );
                        },
                      );
                    
                      }
                      return Container();
                      
                      },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
