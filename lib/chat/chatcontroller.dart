import 'package:cloud_firestore/cloud_firestore.dart';
 
import 'package:main_project/chat/chatmain.dart';
import 'package:main_project/chat/model.dart';
import 'package:main_project/utils/String.dart';

class ChatService {
  final db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return db.collection('firebase').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String reciverID, message) async {
    final String curentUserID = auth.currentUser!.uid;
    final String curentemail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    ChatMessage newmessage = ChatMessage(
      receiverId: reciverID,
      senderId: curentUserID,
     timestamp: timestamp,
     text: message, 
     senderemail: curentemail
      
    );

    List<String> ids = [curentUserID, reciverID];

    ids.sort();

    String chatroomid = ids.join('_');

    await db
        .collection('Chat_room')
        .doc(chatroomid)
        .collection('message')
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserid) {
    List<String> ids = [userId, otherUserid];

    ids.sort();

    String chatroomid = ids.join('_');

    return db
        .collection('Chat_room')
        .doc(chatroomid)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }




Future<void> deleteMessage(String userId, String otherUserId, String messageId) async {
  List<String> ids = [userId, otherUserId];

  ids.sort();

  String chatroomId = ids.join('_');

  try {
    await db
        .collection('Chat_room')
        .doc(chatroomId)
        .collection('message')
        .doc(messageId)
        .delete();
    print('Message deleted successfully');
  } catch (e) {
    print('Error deleting message: $e');
  }
}


Future<void> deleteAllMessages(String userId, String otherUserId) async {
  List<String> ids = [userId, otherUserId];
  ids.sort();
  String chatroomid = ids.join('_');

  CollectionReference messagesRef = db
      .collection('Chat_room')
      .doc(chatroomid)
      .collection('message');

  // Fetch all the documents in the 'message' collection
  QuerySnapshot querySnapshot = await messagesRef.get();

  // Iterate through the documents and delete each one
  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    await doc.reference.delete();
  }
}

}