import 'package:flutter/material.dart';
import 'package:smfp/view/widgets/custom_button.dart';

Widget customButton({subjects, formKey, controller, days, currentDay}) {
  return Container(
    margin: const EdgeInsets.only(right: 30),
    child: MainButton(
        text: 'حفظ البيانات',
        pressed: () {
          List temp = [];
          subjects.forEach((element) {
            temp.add(element.id);
          });
          if (formKey.currentState!.validate()) {
            controller.addSchedule(
              classId: controller.currentClass.id,
              day: days[currentDay],
              subjects: temp,
            );
          }
        }),
  );
}


