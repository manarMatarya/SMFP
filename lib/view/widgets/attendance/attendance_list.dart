import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/home_controller.dart';
import 'package:smfp/view/widgets/attendance/attendance_items.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        return controller.attendanceModel.isEmpty
            ? Center(
                child: Text('no data'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.attendanceModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return (controller.attendanceModel[index].status == 'معذور')
                      ? withExcuseItem(
                          status: controller.attendanceModel[index].status,
                          reason: controller.attendanceModel[index].reason,
                          date: controller.attendanceModel[index].date,
                        )
                      : withoutExcuseItem(
                          status: controller.attendanceModel[index].status,
                          reason: controller.attendanceModel[index].reason,
                          date: controller.attendanceModel[index].date,
                        );
                },
              );
      },
    );
  }
}
