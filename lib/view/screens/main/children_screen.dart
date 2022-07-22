import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/view/screens/main/add_student.dart';
import 'package:smfp/view/widgets/children/children_items.dart';
import 'package:smfp/view/widgets/children/children_list.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class ChildrenScreen extends StatelessWidget {
  ChildrenScreen({Key? key}) : super(key: key);

  final ChildrenController controller =
      Get.put(ChildrenController(), permanent: true);
var fbm =FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    
    fbm.getToken().then((token) {
      print("==============");
      print(token);
      print("==============");
    });


  
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.studentModel.value = [];
      controller.getStudent();
    });
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      TextUtils(
                        text: "أسماء الأبناء",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ChildrenList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: showToolTip(),
      ),
    );
  }
}
