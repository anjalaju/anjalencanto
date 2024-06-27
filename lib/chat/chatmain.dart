import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/chat/chatcontroller.dart';
import 'package:main_project/chat/chatpage.dart';
import 'package:main_project/utils/String.dart';

class ChatRoom extends StatelessWidget {
  
  ChatRoom({super.key});

  final ChatService chatservice = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chatroom'),
          
        ),
        body: _buildUSerList());
  }
}

Widget _buildUSerList() {
  return StreamBuilder(
    stream: ChatService().getUserStream(),
    builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      return ListView(
          children: snapshot.data!
              .map<Widget>(
                (userdata) => buldUserListitem(
                  userdata,
                  context,
                ),
              )
              .toList());
    },
  );
}

User? getcurent() {
  return auth.currentUser;
}

Widget buldUserListitem(Map<String, dynamic> userData, BuildContext context) {
  if (userData['Email'] != getcurent()!.email) {
    return UserTile(
      text: userData['Email'],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              reciveerID: userData['Id'],
              reciveeremail: userData['Email'],
            ),
          ),
        );
      },
    );
  } else {
    return Container();
  }
}

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Icon(Icons.person),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}

// final auth = FirebaseAuth.instance;
// final db = FirebaseFirestore.instance;