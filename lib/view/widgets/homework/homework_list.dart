import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/homework_controller.dart';
import 'package:smfp/view/widgets/custom_shimmer.dart';
import 'package:smfp/view/widgets/homework/homework_item.dart';
import 'package:smfp/view/widgets/homework/homework_skelton.dart';
import 'package:smfp/view/widgets/no_data.dart';

class HomeworlList extends StatelessWidget {
  const HomeworlList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeworkController>(
      builder: ((controller) {
        return controller.loadingHomework.value
            ? customShimmer(item: const HomeworkCardSkelton())
            : controller.homeworks.isEmpty
                ? const NoData()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var homework =
                          controller.homeworks[index].keys.toList().toString();
                      return buildHomeworkItems(
                        date: controller
                            .homeworks[index]
                                [homework.substring(1, homework.length - 1)]
                            .date,
                        content: controller
                            .homeworks[index]
                                [homework.substring(1, homework.length - 1)]
                            .content,
                        course: homework.substring(1, homework.length - 1),
                        title: controller
                            .homeworks[index][homework.substring(
                          1,
                          homework.length - 1,
                        )]
                            .title,
                      );
                    },
                    itemCount: controller.homeworks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
      }),
    );
  }
}
