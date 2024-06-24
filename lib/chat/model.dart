import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String senderemail;
  final String receiverId;
  final String text;
  final Timestamp timestamp;


  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.senderemail,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
      'senderemail':senderemail,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      text: map['text'],
      timestamp: map['timestamp'],
      senderemail: map['senderemail'],
);
}
}