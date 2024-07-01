import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: const Text('Chatroom'),
        ),
        body: _buildUSerList());
  }
}

Widget _buildUSerList() {
  return StreamBuilder(
    stream: ChatService().getUserStream(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
    print('.........${userData}');
    return UserTile(
      email: userData['Email'],
      name: userData['User_Name'],
      phoneno: userData['Mobile_No'],
      image: userData['Image'],
      place: userData['Place'],
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
  final String phoneno;
  final String email;
  final String name;
  final String image;
  final String place;

  final void Function()? onTap;
  UserTile(
      {super.key,
      required this.phoneno,
      required this.email,
      required this.name,
      required this.image,
      required this.place,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          tileColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: image == null || image.isEmpty
              ? const CircleAvatar(radius: 26,
                  backgroundImage: AssetImage('images/propic.png'),
                )
              : Container(
                  width:50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(image),fit: BoxFit.cover,
                    ),
                  ),
                ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $name',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Place: $place',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Email: $email',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Phone: $phoneno',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// final auth = FirebaseAuth.instance;
// final db = FirebaseFirestore.instance;