import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/home/marks_details_screen.dart';

Widget markItem({
  required String course,
  required int result,
  required int total,
}) {
  String grade = '';
  double avg = (result / total) * 100;
  if (avg >= 90) {
    grade = 'ممتاز';
  } else if (avg >= 80 && avg < 90) {
    grade = 'جيد جدا';
  } else if (avg >= 70 && avg < 80) {
    grade = 'جيد';
  } else if (avg >= 60 && avg < 70) {
    grade = 'متوسط';
  } else if (avg >= 50 && avg < 60) {
    grade = 'مقبول';
  } else {
    grade = 'راسب';
  }

  return ListTile(
    title: Text(
      course,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    subtitle: ListTile(
      leading: const Text('الدرجة'),
      title: Text(
        grade,
        style: const TextStyle(
            color: theme.secondaryColor, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        '$total / $result',
        style: const TextStyle(
            color: theme.secondaryColor, fontWeight: FontWeight.bold),
      ),
    ),
    trailing: InkWell(
      onTap: () {
        Get.to(() => MarksDetailsScreen(
              course: course,
            ));
      },
      child: const CircleAvatar(
        backgroundColor: theme.mainColor,
        child: Icon(
          Icons.navigate_next_sharp,
          color: Colors.white,
        ),
      ),
    ),
  );
}
