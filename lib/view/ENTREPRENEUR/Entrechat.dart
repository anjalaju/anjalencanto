import 'package:flutter/material.dart';

class EntreChatpage extends StatefulWidget {
  String name;
  EntreChatpage({super.key, required this.name});

  @override
  State<EntreChatpage> createState() => _EntreChatpageState();
}

class _EntreChatpageState extends State<EntreChatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: IconButton(
                  onPressed: () {
                    // Handle send message action
                  },
                  icon: Icon(Icons.send),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.name,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffCCCACA),
                      borderRadius: BorderRadius.circular(10)),
                  height: 35,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello"),
                        Text("2 40 am"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff949494),
                      borderRadius: BorderRadius.circular(10)),
                  height: 35,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello"),
                        Text("2 40 am"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
