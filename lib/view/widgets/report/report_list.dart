import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/report_controller.dart';
import 'package:smfp/view/screens/more/report_details_screen.dart';
import 'package:smfp/view/widgets/no_data.dart';
import 'package:smfp/view/widgets/report/report_item.dart';

class ReportList extends StatelessWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ReportsController>(builder: (controller) {
      return controller.reports.isEmpty
          ? const NoData()
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      ReportDetailsScreen(
                        report: controller.reports[index],
                      ),
                    );
                  },
                  child: buildHomeworkItems(
                    content: controller.reports[index].content,
                    title: controller.reports[index].title,
                    date: controller.reports[index].date_created,
                  ),
                );
              },
              itemCount: controller.reports.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            );
    });
  }
}
