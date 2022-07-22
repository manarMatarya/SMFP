import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/utiles/theme.dart';

class ClassField extends StatefulWidget {
  const ClassField({Key? key}) : super(key: key);

  @override
  State<ClassField> createState() => _ClassFieldState();
}

class _ClassFieldState extends State<ClassField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: GetX<TeacherControllerBasic>(builder: (controller) {
        return DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'من فضلك حدد الفصل';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFCA870).withOpacity(0.3),
            contentPadding: const EdgeInsets.all(20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFFCA870).withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFFCA870).withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFFCA870).withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFFCA870).withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(10),
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
          onChanged: (value) {
            setState(() {
              controller.currentClass = value;
            });
          },
        );
      }),
    );
  }
}

Widget contentItem({
  required int line,
  required var control,
  bool enabled = true,
}) {
  String msg = '';
  return Material(
    borderRadius: BorderRadius.circular(10),
    child: TextFormField(
      validator: (value) {
        if (value.toString().isEmpty) {
          msg = 'لا يمكن أن يكون أحد الحقول فارغة';
          Get.snackbar(
            'خطأ',
            msg,
            backgroundColor: theme.mainYellow,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return '';
        } else {
          return null;
        }
      },
      minLines: line,
      maxLines: 12,
      enabled: enabled,
      controller: control,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFCA870).withOpacity(0.3),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFFCA870).withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFFCA870).withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFFCA870).withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFFCA870).withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
