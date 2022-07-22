import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/utiles/theme.dart';

Widget markFloatingButton() {
  TeacherControllerBasic controller = Get.put(TeacherControllerBasic());

  final fromKey = GlobalKey<FormState>();

  List<TextEditingController> _controllers = [];

  TextEditingController totalController = TextEditingController();
  void clearText() {
    for (var element in _controllers) {
      element.clear();
    }
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 220,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(5),
              backgroundColor: MaterialStateProperty.all(theme.mainColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: () {
              if (fromKey.currentState!.validate()) {
                for (int i = 0; i < _controllers.length; i++) {
                  controller.addExamResult(
                    result: _controllers[i].text,
                    studentId: controller.students[i].id,
                    total: totalController.text,
                  );
                  clearText();
                }
              } else {
                Get.snackbar(
                  'خطأ',
                  'أدخل جميع العلامات',
                  colorText: Colors.white,
                  backgroundColor: theme.mainColor,
                );
              }
            },
            child: const Text(
              'حفظ الدرجات',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          height: 50,
          child: TextFormField(
            validator: (v) {
              if (v.toString().isEmpty) {
                return 'ادخل العلامة النهائية للاختبار';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: theme.mainColor),
            controller: totalController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'total mark',
              hintStyle: const TextStyle(color: theme.mainColor),
              filled: true,
              fillColor: Colors.white,
              //  contentPadding: const EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
