import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/view/widgets/custom_shimmer.dart';
import 'package:smfp/view/widgets/mark/mark_item.dart';
import 'package:smfp/view/widgets/mark/mark_skelton.dart';
import 'package:smfp/view/widgets/no_data.dart';

class Marks extends StatelessWidget {
  const Marks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ExamController>(
      builder: ((controller) {
        List courses = controller.marks.keys.toList();

        return controller.loadingMarks.value
            ? customShimmer(item: const MarksCardSkelton())
            : controller.marks.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.marks.length,
                    itemBuilder: (context, index) {
                      var result = 0.0;
                      var total = 0.0;
                      for (int i = 0;
                          i < controller.marks[courses[index]].length;
                          i++) {
                        result += controller.marks[courses[index]][i].result;
                        total += controller.marks[courses[index]][i].total;
                      }

                      return markItem(
                        course: courses[index],
                        result: result.toInt(),
                        total: total.toInt(),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                        color: Colors.black,
                      );
                    },
                  )
                : const NoData();
      }),
    );
  }
}
