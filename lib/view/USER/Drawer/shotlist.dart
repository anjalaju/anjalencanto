import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_project/view/USER/Drawer/Shotlist1.dart';

class Shortlist extends StatefulWidget {
  const Shortlist({super.key});

  @override
  State<Shortlist> createState() => _ShortlistState();
}

class _ShortlistState extends State<Shortlist> {
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
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Shortlistphotographer(),
                  ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage("images/photographers.png"),
                                fit: BoxFit.cover),
                            // color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        height: 140,child: const Column(
                        children: [
                          Text("Photographers"),
                        ],
                      ),
                                       
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Container(decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage("images/Decor.jpg"),
                                fit: BoxFit.cover),
                            // color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        height: 140,child: const Column(
                        children: [
                          Text("Decor"),
                        ],
                      ),
                                       
                      ),
                    )
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
