import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/chat/chatcontroller.dart';
import 'package:main_project/chat/chatmain.dart';
import 'package:main_project/model/enterprenurmodel.dart';
import 'package:main_project/utils/String.dart';

class ChatPage extends StatefulWidget {
  final String reciveeremail;
  final String reciveerID;

  ChatPage({
    super.key,
    required this.reciveeremail,
    required this.reciveerID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();

  final messagecontroller = TextEditingController();

  

  

  
  void sendMessage() async {
    if (messagecontroller.text.isNotEmpty) {
      await chatService.sendMessage(widget.reciveerID, messagecontroller.text);

      messagecontroller.clear();
    }
  }

  EnterprenurModel? enterprenurModel;
  Stream getReciverdetails() {
    return db.collection('enterprenur').doc(widget.reciveerID).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: getReciverdetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
              return Text('');
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            var profileImage = data['profileImage'] ?? '';
            var entrepreneurEmail = data['entrepreneurEmail'] ?? '';

            return Row(
              children: [
                Container(
                  width: Helper.W(context) * .080,
                  height: Helper.h(context) * .060,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          profileImage,
                        ),
                      )),
                ),
                SizedBox(
                  width: Helper.W(context) * .05,
                ),

                Text(entrepreneurEmail),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserInput(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    String senderID = auth.currentUser!.uid;

    return StreamBuilder(
      stream: ChatService().getMessage(widget.reciveerID, senderID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading....');
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => buildMessage(doc)).toList(),
        );
      },
    );
  }

  Widget buildMessage(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurentUser = data['senderId'] == auth.currentUser!.uid;
    var alignment = isCurentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['text'],
              isCurentUSer: isCurentUser,
            )
          ],
        ),
      ),
    );
  }

  Widget buildUserInput() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messagecontroller,
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.arrow_upward),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurentUSer;
  ChatBubble({
    super.key,
    required this.isCurentUSer,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCurentUSer ? Colors.green : Colors.grey,
      child: Text(message),
    );
  }
}