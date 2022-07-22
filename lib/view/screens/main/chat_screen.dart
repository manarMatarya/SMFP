import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/auth_controller.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/logic/controller/message_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/chat/message_line.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  ChildrenController childrenController = Get.put(ChildrenController());
  MessageController messageController = Get.put(MessageController());
  AuthController authController = Get.put(AuthController());

  String messageText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.mainColor,
          leading: Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    messageController.teacher.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            messageController.teacher.name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MessageStreamBuilder(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 32,
                        color: theme.mainColor.withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sentiment_satisfied_alt_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.64),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: messageTextController,
                                  onChanged: (value) {
                                    messageText = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "اكتب هنا",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    messageTextController.clear();
                                    messageController.sendMessage(
                                      messageText: messageText,
                                      sender: messageController.teacher.phone,
                                      reciever: messageController.teacher.phone,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: theme.mainColor,
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ));
  }
}

// ignore: must_be_immutable
class MessageStreamBuilder extends StatelessWidget {
  MessageStreamBuilder({Key? key}) : super(key: key);
  ChildrenController childrenController = Get.put(ChildrenController());
  MessageController messageController = Get.put(MessageController());
  AuthController authController = Get.put(AuthController());
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messagewidgets = [];
          if (!snapshot.hasData) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: theme.mainColor,
                  backgroundColor: Colors.grey[300],
                ),
              ),
            );
            //add here a spinner
          }
          final messages = snapshot.data!.docs.reversed;

          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageTime = message.get('time');
            final messageReciever = message.get('reciever');
            final currentUser = messageController.teacher.phone;
            if (messageReciever == currentUser ||
                messageSender == currentUser) {
              final messagewidget = MessageLine(
                sender: messageSender,
                text: messageText,
                isMe: currentUser == messageSender,
                time: messageTime,
              );

              messagewidgets.add(messagewidget);
            }
          }

          if (messagewidgets.isEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/nochat.png',
                      width: 100,
                      height: 100,
                    ),
                    const Text(
                      'ابدأ محادثة مع المعلم ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
            //add here a spinner
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagewidgets,
            ),
          );
        });
  }
}
