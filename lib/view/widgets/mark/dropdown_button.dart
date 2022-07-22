import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/utiles/theme.dart';

class SemesterDropDown extends StatefulWidget {
  const SemesterDropDown({Key? key}) : super(key: key);

  @override
  State<SemesterDropDown> createState() => _SemesterDropDownState();
}

class _SemesterDropDownState extends State<SemesterDropDown> {
  ExamController controller = Get.put(ExamController());

  getMarks() async {
    await controller.getMarks();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ExamController>(builder: (controller) {
      return DropdownButtonFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: theme.mainColor.withOpacity(0.2),
            filled: true,
            prefixIcon: const Icon(
              Icons.list,
              color: theme.secondaryColor,
            ),
          ),
          items: controller.semesters.map((semester) {
            return DropdownMenuItem(
              value: semester,
              child: Text(
                semester.name,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(controller.currentSemester.value.name),
          onChanged: (value) {
            setState(() async {
              controller.currentSemester.value = value;

              controller.marks.value = {};
              controller.getMarks();
            });
          });
    });
  }
}
