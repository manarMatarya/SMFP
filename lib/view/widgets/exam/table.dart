import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/no_data.dart';

class ExamTable extends StatelessWidget {
  const ExamTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ExamController>(builder: (controller) {
      return controller.loadingExams.value
          ? const Center(
              child: SizedBox(
                height: 450,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: theme.mainColor,
                  ),
                ),
              ),
            )
          : controller.exams.isEmpty
              ? const NoData()
              : Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        theme.mainColor.withOpacity(0.3)),
                    headingTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryColor),
                    dataTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: theme.mainColor),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'المادة',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'التاريخ',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'الساعة',
                        ),
                      ),
                    ],
                    rows: [
                      for (int i = 0; i < controller.exams.length; i++)
                        buildRowItems(
                          name: controller.exams[i].keys
                              .toList()
                              .toString()
                              .substring(
                                  1,
                                  controller.exams[i].keys
                                          .toList()
                                          .toString()
                                          .length -
                                      1),
                          date: controller
                              .exams[i][controller.exams[i].keys
                                  .toList()
                                  .toString()
                                  .substring(
                                      1,
                                      controller.exams[i].keys
                                              .toList()
                                              .toString()
                                              .length -
                                          1)]
                              .date,
                          time: controller
                              .exams[i][controller.exams[i].keys
                                  .toList()
                                  .toString()
                                  .substring(
                                      1,
                                      controller.exams[i].keys
                                              .toList()
                                              .toString()
                                              .length -
                                          1)]
                              .time,
                        ),
                    ],
                  ),
                );
    });
  }
}

DataRow buildRowItems({
  required String name,
  required String date,
  required String time,
}) {
  return DataRow(cells: [
    DataCell(Text(name)),
    DataCell(Text(date)),
    DataCell(Text(time)),
  ]);
}
