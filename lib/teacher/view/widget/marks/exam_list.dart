import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/screens/add_students_mark.dart';
import 'package:smfp/teacher/view/widget/marks/marks.items.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/no_data.dart';

class ExamList extends StatelessWidget {
  const ExamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TeacherControllerBasic>(
      builder: ((controller) {
        return controller.isLoading.value
            ? Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 104, 103, 103),
                highlightColor: theme.mainColor,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) => examsCardSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ))
            : controller.exams.isEmpty
                ? const NoData()
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.exams.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          controller.currentExam.value =
                              controller.exams[index];

                          Get.to(const AddStudentsMark());
                        },
                        child: listItem(controller.exams[index].name),
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
      }),
    );
  }
}
