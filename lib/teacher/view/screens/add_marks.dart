import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/widget/marks/exam_list.dart';
import 'package:smfp/teacher/view/widget/marks/exam_type.dart';

import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddMarks extends StatefulWidget {
  const AddMarks({Key? key}) : super(key: key);

  @override
  State<AddMarks> createState() => _AddMarksStrate();
}

class _AddMarksStrate extends State<AddMarks> {
  TeacherControllerBasic controller = Get.put(TeacherControllerBasic());
  late String examShowType;
  @override
  void initState() {
    examShowType = 'كويز';
    controller.exams.value = [];
    controller.getExams(examShowType);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  TextUtils(
                    text: "ادخال درجات ",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ExamType(),
                  const SizedBox(
                    height: 20,
                  ),
                  const ExamList(),
                ],
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
