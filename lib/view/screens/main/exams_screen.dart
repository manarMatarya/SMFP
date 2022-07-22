import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/view/widgets/exam/dropdown_button.dart';
import 'package:smfp/view/widgets/exam/table.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  ExamController controller = Get.put(ExamController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.exams.value = [];

    controller.getExams(examType: 'نصفي');

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
                        text: "جدول الاختبارات",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ExamDropDown(),
                      const SizedBox(
                        height: 10,
                      ),
                      const ExamTable(),
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
