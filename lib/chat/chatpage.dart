import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      // appBar: AppBar(
      //   title: StreamBuilder(
      //     stream: getReciverdetails(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return CircularProgressIndicator();
      //       }
      //       if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
      //         return Text('');
      //       }

      //       var data = snapshot.data!.data() as Map<String, dynamic>;
      //       var profileImage = data['profileImage'] ?? '';
      //       var entrepreneurEmail = data['entrepreneurName'] ?? '';

      //       return Row(
      //         children: [
      //           Container(
      //             width: Helper.W(context) * .080,
      //             height: Helper.h(context) * .060,
      //             decoration: BoxDecoration(
      //                 color: Colors.red,
      //                 shape: BoxShape.circle,
      //                 image: DecorationImage(
      //                   image: NetworkImage(
      //                     profileImage,
      //                   ),
      //                 )),
      //           ),
      //           SizedBox(
      //             width: Helper.W(context) * .05,
      //           ),

      //           Text(entrepreneurEmail),
      //         ],
      //       );
      //     },
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: FutureBuilder<List<MapEntry<String, dynamic>>>(
          future: getUserDetails(widget.reciveerID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Text('');
            }

            var data = Map<String, dynamic>.fromEntries(snapshot.data!);
            var profileImageEnt = data['profileImage'] ?? '';
            var profileImageUser = data['Image'] ?? '';
            var userType = data['userType'];
            var userName = data['User_Name'] ?? '';
            var entrepreneurName = data['entrepreneurName'] ?? '';

            return Row(
              children: [
                userType == 'enterprenur'
                    ? (profileImageEnt.isEmpty
                        ? const CircleAvatar(
                            backgroundImage: AssetImage('images/propic.png'),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * .080,
                            height: MediaQuery.of(context).size.height * .060,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(profileImageEnt),
                              ),
                            ),
                          ))
                    : (profileImageUser.isEmpty
                        ? const CircleAvatar(
                            backgroundImage: AssetImage('images/propic.png'),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * .080,
                            height: MediaQuery.of(context).size.height * .060,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(profileImageUser),
                              ),
                            ),
                          )),
                SizedBox(width: MediaQuery.of(context).size.width * .05),
                Text(userType == 'enterprenur' ? entrepreneurName : userName),
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
          return const Text('Loading....');
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
    print('===${data}');
    bool isCurentUser = data['senderId'] == auth.currentUser!.uid;
    var alignment = isCurentUser ? Alignment.centerRight : Alignment.centerLeft;
    var timestamp = data['timestamp'];
    var formattedTime = '';

    var dateTime = timestamp.toDate();
    formattedTime = DateFormat.yMMMd().add_jm().format(dateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['text'],
              isCurentUSer: isCurentUser,
            ),
            Text(
              formattedTime,
              style: TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messagecontroller,
              decoration: const InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward),
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              10,
            ),
            topRight: Radius.circular(
              15,
            ),
            bottomLeft: Radius.circular(10)),
        color:
            isCurentUSer ? const Color.fromARGB(255, 63, 133, 65) : Colors.grey,
      ),
      child: Text(
        message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

Future<List<MapEntry<String, dynamic>>> getUserDetails(String userID) async {
  // Fetching user details from different collections
  DocumentSnapshot entrepreneurSnapshot =
      await db.collection('enterprenur').doc(userID).get();
  DocumentSnapshot userSnapshot =
      await db.collection('firebase').doc(userID).get();

  Map<String, dynamic> userDetails = {};

  if (entrepreneurSnapshot.exists) {
    userDetails.addAll(entrepreneurSnapshot.data() as Map<String, dynamic>);
  }
  if (userSnapshot.exists) {
    userDetails.addAll(userSnapshot.data() as Map<String, dynamic>);
  }

  // Convert the combined map into a list of key-value pairs
  return userDetails.entries.toList();
}
