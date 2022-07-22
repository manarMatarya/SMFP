import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/utiles/theme.dart';

class ClassDropDown extends StatefulWidget {
  const ClassDropDown({Key? key}) : super(key: key);

  @override
  State<ClassDropDown> createState() => _ClassDropDownState();
}

class _ClassDropDownState extends State<ClassDropDown> {
  @override
  Widget build(BuildContext context) {
    return GetX<TeacherControllerBasic>(builder: (controller) {
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
          items: controller.classes.map((clas) {
            return DropdownMenuItem(
              value: clas,
              child: Text(
                clas.name,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(controller.classes[0].name),
          onChanged: (value) {
            setState(() {
              controller.currentClass = value;

              controller.students.value = [];
              controller.getStudents();
            });
          });
    });
  }
}
