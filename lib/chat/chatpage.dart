import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/chat/chatcontroller.dart';
import 'package:main_project/model/enterprenurmodel.dart';
import 'package:main_project/utils/String.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  final String reciveeremail;
  final String reciveerID;

  const ChatPage({
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
            var enterprenurNumber = data['entrepreneurNumber'] ?? '';
            var userNumber = data['Mobile_No'] ?? '';
            print('entnum$enterprenurNumber');
            print('usernum$userNumber');
            print(']]]]]]]]]$data');
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    userType == 'enterprenur'
                        ? (profileImageEnt.isEmpty
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/propic.png'),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * .080,
                                height:
                                    MediaQuery.of(context).size.height * .060,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(profileImageEnt),
                                  ),
                                ),
                              ))
                        : (profileImageUser.isEmpty
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/propic.png'),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * .080,
                                height:
                                    MediaQuery.of(context).size.height * .060,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(profileImageUser),
                                  ),
                                ),
                              )),
                    SizedBox(width: MediaQuery.of(context).size.width * .05),
                    Text(userType == 'enterprenur'
                        ? entrepreneurName
                        : userName),
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (userType == 'enterprenur') {
                      if (userNumber != null && userNumber.isNotEmpty) {
                        _makePhoneCall(userNumber);
                      } else {
                        print('Calling enterprenur number: $enterprenurNumber');
                        _makePhoneCall(enterprenurNumber);
                      }
                    } else {
                      if (enterprenurNumber != null &&
                          enterprenurNumber.isNotEmpty) {
                        _makePhoneCall(enterprenurNumber);
                      } else {
                        print('Calling user number: $userNumber');
                        _makePhoneCall(userNumber);
                      }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Icon(Icons.call),
                  ),
                )
              ],
            );
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/chatwallpaper.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(child: buildMessageList()),
            buildUserInput(),
          ],
        ),
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
      child: InkWell(onTap: () {        print('${doc.id}******');

      },
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
                style: const TextStyle(fontSize: 9, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInput() {
    // final _scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: messagecontroller,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey,
                    size: 28,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.black,
                      context: context,
                      builder: (_) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: messagecontroller,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Message',
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            color: Colors.indigo),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            color: Colors.indigo),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            color: Colors.indigo),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Add your send button logic here
                                    print(
                                        'Message sent: ${messagecontroller.text}');
                                    sendMessage();
                                    messagecontroller.clear();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                messagecontroller
                                  ..text += emoji.emoji
                                  ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: messagecontroller.text.length),
                                  );
                              },
                              config: Config(
                                height: 256,
                                checkPlatformCompatibility: true,
                                emojiViewConfig: EmojiViewConfig(
                                  emojiSizeMax: 28 *
                                      (foundation.defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                          ? 1.2
                                          : 1.0),
                                ),
                                swapCategoryAndBottomBar: false,
                                skinToneConfig: const SkinToneConfig(),
                                categoryViewConfig: const CategoryViewConfig(),
                                bottomActionBarConfig:
                                    const BottomActionBarConfig(),
                                searchViewConfig: const SearchViewConfig(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                isDense: true,
                hintText: 'Message',
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.indigo)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.indigo)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.indigo)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.indigo, shape: BoxShape.circle),
              child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
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
        color: isCurentUSer
            ? const Color.fromARGB(255, 63, 133, 65)
            : const Color.fromARGB(255, 68, 63, 63),
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

void _makePhoneCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
