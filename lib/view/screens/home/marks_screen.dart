import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/view/widgets/mark/dropdown_button.dart';
import 'package:smfp/view/widgets/mark/marks.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

// ignore: must_be_immutable
class MarksScreen extends StatefulWidget {
  const MarksScreen({Key? key}) : super(key: key);

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  ExamController controller = Get.put(ExamController());

// @override
//   void initState() {
//      Future.delayed(const Duration(milliseconds: 100), () {
//       controller.marks.value = {};
//       controller.getMarks();
//     });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    controller.marks.value = {};
    controller.getMarks();

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                TextUtils(
                  text: "الدرجات",
                ),
                const SizedBox(
                  height: 10,
                ),
                const SemesterDropDown(),
                const SizedBox(
                  height: 10,
                ),
                const Marks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
