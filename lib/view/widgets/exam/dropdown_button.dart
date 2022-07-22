import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/utiles/theme.dart';

class ExamDropDown extends StatefulWidget {
  const ExamDropDown({Key? key}) : super(key: key);

  @override
  State<ExamDropDown> createState() => _ExamDropDownState();
}

class _ExamDropDownState extends State<ExamDropDown> {
  ExamController controller = Get.put(ExamController());

  List exam = ['نصفي', 'نهائي'];
  var examType = 'نصفي';
  @override
  Widget build(BuildContext context) {
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
        suffixIconColor: theme.mainColor,
        fillColor: theme.secondaryColor.withOpacity(0.3),
        filled: true,
        prefixIcon: const Icon(
          Icons.list,
          color: theme.mainColor,
        ),
      ),
      items: exam.map((exam) {
        return DropdownMenuItem(
          value: exam,
          child: Text(
            exam,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(exam[0]),
      onChanged: (value) {
        setState(() {
          examType = value.toString();

          controller.exams.value = [];

          controller.getExams(examType: examType);
        });
      },
    );
  }
}
