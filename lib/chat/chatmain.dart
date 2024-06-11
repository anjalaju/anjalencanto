import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/chat/messageController.dart';
import 'package:main_project/chat/model.dart';
import 'package:main_project/chat/profilemodel.dart';

class ChatPage extends StatefulWidget {
  Myprofilemodel? senderProfileModel;
  ChatPage({super.key, required this.senderProfileModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final String receiverId = ; // Replace with actual receiver ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const cprofile()));
          },
          child: Text(
            widget.senderProfileModel!.firstname,
            style: TextStyle(color: Colors.white),
          ),
        ), // Replace with contact name or image
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, // Go back
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           const videocall()), // Replace with your ServicesPage widget
              // );
            },
            icon: const Icon(Icons.video_camera_front, color: Colors.white),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: MessageController().receiveMessage(
                  widget.senderProfileModel!.id,
                  FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<ChatMessage> messages = snapshot.data!.docs.map((doc) {
                  return ChatMessage.fromMap(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                return ListView.builder(
                  reverse: true, // Display newest messages at the top
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessage(message);
                  },
                );
              },
            ),
          ),
          // Chat input bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showAttachmentMenu(context);
                    },
                    icon: const Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        MessageController().sendMessage(
                            widget.senderProfileModel!.id!,
                            _messageController.text);
                        _messageController.clear();
                      }
                    },  
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final isMe = message.senderId == _auth.currentUser!.uid;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.lightBlueAccent : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
            bottomLeft:
                isMe ? const Radius.circular(15.0) : const Radius.circular(0.0),
            bottomRight:
                isMe ? const Radius.circular(0.0) : const Radius.circular(15.0),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // void _sendMessage() {
  //   if (_messageController.text.isEmpty) {
  //     return;
  //   }

  //   final chatMessage = ChatMessage(
  //     senderId: _auth.currentUser!.uid,
  //     receiverId: ,
  //     text: _messageController.text,
  //     timestamp: Timestamp.now(),
  //   );

  //   _firestore.collection('messages').add(chatMessage.toMap());
  //   _messageController.clear();
  // }

  void _showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  // Implement gallery option
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  // Implement camera option
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('Document'),
                onTap: () {
                  // Implement document option
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
