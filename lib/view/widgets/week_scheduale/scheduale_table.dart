import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/home_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/week_scheduale/scheduale_raw_item.dart';

class SchedualeTable extends StatelessWidget {
  const SchedualeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List days = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];

    return GetX<HomeController>(builder: (controller) {
      return controller.weekScheduale.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: DataTable(
                columnSpacing: 10,
                headingRowColor:
                    MaterialStateProperty.all(theme.mainColor.withOpacity(0.3)),
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
                      'اليوم',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'الأولى',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'الثانية',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'الثالثة',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'الرابعة',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'الخامسة',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'السادسة',
                    ),
                  ),
                ],
                rows: [
                  for (int i = 0; i < days.length; i++)
                    buildRowItems(
                        day: days[i],
                        one: controller.weekScheduale[days[i]][0],
                        two: controller.weekScheduale[days[i]][1],
                        three: controller.weekScheduale[days[i]][2],
                        four: controller.weekScheduale[days[i]][3],
                        five: controller.weekScheduale[days[i]][4],
                        six: controller.weekScheduale[days[i]][5])
                ],
              ),
            );
    });
  }
}
