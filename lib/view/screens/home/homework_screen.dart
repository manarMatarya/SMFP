import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/homework_controller.dart';
import 'package:smfp/view/widgets/homework/homework_list.dart';
import 'package:smfp/view/widgets/my_appbar.dart';

import 'package:smfp/view/widgets/text_utils.dart';

// ignore: must_be_immutable
class HomeworkScreen extends StatelessWidget {
  HomeworkScreen({Key? key}) : super(key: key);

  HomeworkController controller = Get.put(HomeworkController());

  @override
  Widget build(BuildContext context) {
    controller.homeworks.value = [];
    controller.getHomeworks();
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
                        text: "الواجبات",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const HomeworlList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
