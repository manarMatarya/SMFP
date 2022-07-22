import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/widget/marks/drop_down.dart';
import 'package:smfp/teacher/view/widget/marks/mark_floating_button.dart';
import 'package:smfp/teacher/view/widget/marks/mark_student_list.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddStudentsMark extends StatefulWidget {
  const AddStudentsMark({Key? key}) : super(key: key);

  @override
  State<AddStudentsMark> createState() => _AddStudentsMarkState();
}
class _AddStudentsMarkState extends State<AddStudentsMark> {
  TeacherControllerBasic controller = Get.put(TeacherControllerBasic());

  @override
  Widget build(BuildContext context) {
    controller.currentClass = controller.classes[0];

    controller.students.value = [];
    controller.getStudents();

    return SafeArea(
      child: Scaffold(
          appBar: myAppBar(),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      TextUtils(
                        text:
                            " ادخال درجات " + controller.currentExam.value.name,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ClassDropDown(),
                       StudentList(),
                      const SizedBox(
                        height: 400,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          floatingActionButton: markFloatingButton()),
    );
  }
}

