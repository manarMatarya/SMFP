import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/logic/controller/home_controller.dart';
import 'package:smfp/view/screens/home/attendance_screen.dart';
import 'package:smfp/view/screens/home/homework_screen.dart';
import 'package:smfp/view/screens/home/marks_screen.dart';
import 'package:smfp/view/screens/home/weekly_schedule.dart';
import 'package:smfp/view/widgets/home/home_header.dart';
import 'package:smfp/view/widgets/home/image_slider.dart';
import 'package:smfp/view/widgets/main_card.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChildrenController controller =
      Get.put(ChildrenController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                  child: Column(
                    children: [
                      const HomeHeader(),
                      const SizedBox(
                        height: 20,
                      ),
                      ImageSlider(),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 5.0,
                            crossAxisCount: 2,
                            children: [
                              InkWell(
                                onTap: () => Get.to(() => MarksScreen()),
                                child: buildMainCard(
                                  image: 'assets/images/marks.png',
                                  name: 'الدرجات',
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.to(() => HomeworkScreen()),
                                child: buildMainCard(
                                  image: 'assets/images/homework.png',
                                  name: 'الواجبات',
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => WeeklyScheduleScreen()),
                                child: buildMainCard(
                                  image: 'assets/images/scheduals.png',
                                  name: 'الجدول الأسبوعي',
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.to(() => AttendanceScreen()),
                                child: buildMainCard(
                                  image: 'assets/images/attendance.png',
                                  name: 'الحضور والغياب',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
