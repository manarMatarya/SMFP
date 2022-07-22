import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PushNotify extends StatefulWidget {
  const PushNotify({Key? key}) : super(key: key);
  @override
  _PushNotifyState createState() => _PushNotifyState();
}

class _PushNotifyState extends State<PushNotify> {
  var fbm = FirebaseMessaging.instance;
  var serverToken =
      "AAAAdbEHMmA:APA91bFn1ucoE8-8rEgH26D_kh4EKZDMg3Xggr-gfKzB0KAbhfITrtSJhLZ8zd9Ksg31FuwaWnT-tTPMTBCtFhevqYqULpP9ecSrfKkbGCMjf5N7TeRwOK7S0ZeTNu8TJSQut1EylEGG";
  sendNotfiy(String title, String body) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': "/topics/asma"
        },
      ),
    );
  }

  getToken() async {
    print("===========Token==========");
    var token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  getMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      print("======================");
      print(message.notification?.title);
      print(message.notification?.body);
    });
  }

  @override
  void initState() {
    getToken();
    getMessage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: [
          MaterialButton(
              onPressed: () async {
                await sendNotfiy('welcome', 'i am asma');
              },
              child: Text("SEND NOTIFY")),
          MaterialButton(
              onPressed: () async {
                await FirebaseMessaging.instance.subscribeToTopic('asma');
              },
              child: Text("subscribeToTopic")),
          MaterialButton(
              onPressed: () async {
                await FirebaseMessaging.instance.unsubscribeFromTopic('asma');
              },
              child: Text("unsubscribeFromTopic")),
        ],
      ),
    );
  }
}
