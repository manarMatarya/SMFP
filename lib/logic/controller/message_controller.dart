import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';

class MessageController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());

  final _messageRef = FirebaseFirestore.instance.collection('messages');
  dynamic teacher;
//  final teacher = TeacherModel('', '', '', '','','').obs;
  final chatUsers = [].obs;

  sendMessage({
    required String messageText,
    required String? sender,
    required String reciever,
  }) async {
    try {
      await _messageRef.add({
        'text': messageText,
        'sender': sender,
        'time': FieldValue.serverTimestamp(),
        'reciever': reciever,
      });
    } catch (e) {
      print('no chats');
    }
  }
}
