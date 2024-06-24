
import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
 

  @override
  void initState() {
    super.initState(); 
    
      Provider.of<FunctionProvider>(context, listen: false).getAlleventallh();
   
  }
   
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text(
          'Search',
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
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //   ),
        //   color: Colors.black,
        // ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: Helper.h(context) * .010,
              ),
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: ("Search by location"),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.location_on)),
                    onChanged: (value) {
                      helper.searcheven(value);
                      //  setState(() {
                        
                      //  });
                       
                    },

                    
                  );
                },
              ),
              SizedBox(
                height: Helper.h(context) * .10,
              ),
              Consumer<FunctionProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getAllEvent(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      List<EventModel> list=[];


                      list = snapshot.data!.docs.map((e){
                        return EventModel.fromJsone(e.data()as Map<String,dynamic>);
                      }
                      ).toList();

                     

                      final Searchlist = helper.searchevent.isEmpty
                          ? helper.eventall
                          : helper.searchevent;

                          // list.shuffle();

                      return helper.searchevent.isEmpty
                          ? Center(
                              child: Text('note found!'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: Searchlist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 120,
                                  // height: Helper.h(context) * .20,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(
                                        Helper.W(context) * .050),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Helper.W(context) * .050,
                                      vertical: Helper.W(context) * .050,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'EVENT NAME  :${Searchlist[index].eventName}'),
                                                Text(
                                                    'EVENT LOCATION :${Searchlist[index].eventPlace}'),
                                                Text(
                                                  'EVENT CATEGORY :${Searchlist[index].eventmainCategory}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Helper.W(context) *
                                                              .025),
                                                ),
                                                Text(
                                                    'EVENT DISCR :${Searchlist[index].discription}'),
                                              ],
                                            ),
                                            Spacer(),
                                            Container(
                                              width: Helper.W(context) * .25,
                                              height: Helper.h(context) * .140,
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                    Searchlist[index].Image,
                                                  ))),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Helper.h(context) * .030,
                                );
                              },
                            );
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
