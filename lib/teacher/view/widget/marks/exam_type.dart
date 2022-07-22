import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/widget/marks/marks.items.dart';
import 'package:smfp/utiles/theme.dart';

class ExamType extends StatefulWidget {
  const ExamType({Key? key}) : super(key: key);

  @override
  State<ExamType> createState() => _ExamTypeState();
}

class _ExamTypeState extends State<ExamType> {
  TeacherControllerBasic controller = Get.put(TeacherControllerBasic());
  late String examShowType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              examShowType = 'كويز';
              controller.exams.value = [];
              controller.getExams(examShowType);
            });
          },
          child: examType(color: theme.mainColor, text: 'كويزات'),
        ),
        InkWell(
          onTap: () {
            setState(() {
              examShowType = 'نصفي';
              controller.exams.value = [];
              controller.getExams(examShowType);
            });
          },
          child: examType(color: theme.mBroun, text: 'نصفي'),
        ),
        InkWell(
          onTap: () {
            setState(() {
              examShowType = 'نهائي';
              controller.exams.value = [];
              controller.getExams(examShowType);
            });
          },
          child: examType(color: theme.mainYellow, text: 'نهائي'),
        ),
      ],
    );
  }
}
