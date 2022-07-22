import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/home_controller.dart';
import 'package:smfp/view/widgets/attendance/attendance_list.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

// ignore: must_be_immutable
class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextUtils(
                  text: "الحضور والغياب",
                ),
                const SizedBox(
                  height: 10,
                ),
                const AttendanceList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
