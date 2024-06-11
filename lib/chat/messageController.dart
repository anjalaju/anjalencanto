 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
import 'package:main_project/chat/model.dart';

class MessageController {
  final db = FirebaseFirestore.instance;

  sendMessage(String receiverId, message) {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    String receiverUId = receiverId;
    Timestamp timestamp = Timestamp.now();

    ChatMessage messageModel = ChatMessage(
        senderId: senderId,
        receiverId: receiverUId,
        text: message,
        timestamp: timestamp);

    List<String> ids = [senderId, receiverUId];

    ids.sort();

    String chatRoomId = ids.join('_');

    db
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection("message")
        .add(messageModel.toMap());
  }

  Stream<QuerySnapshot> receiveMessage(userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();

    String chatRoomId = ids.join('_');

    return db
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: true)
        .snapshots();
}
}