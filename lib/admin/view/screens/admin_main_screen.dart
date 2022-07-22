import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/admin/view/screens/add_event.dart';
import 'package:smfp/admin/view/screens/add_report.dart';
import 'package:smfp/admin/view/screens/admin_screen.dart';
import 'package:smfp/admin/view/screens/admin_transfer_student.dart';
import 'package:smfp/admin/view/screens/get_complaints.dart';
import 'package:smfp/logic/controller/main_controller.dart';
import 'package:smfp/utiles/theme.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  buildBottomNavigationMenu(context, controller) {
    return Obx(
      () => BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: controller.changeTabIndex,
        currentIndex: controller.tabIndex.value,
        unselectedItemColor: Colors.black,
        selectedItemColor: theme.mainColor,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: const Icon(
                Icons.home_outlined,
                size: 25.0,
              ),
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: const Icon(
                Icons.support_agent,
                size: 25.0,
              ),
            ),
            label: 'الشكاوي',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: const Icon(
                Icons.list_alt_outlined,
                size: 25.0,
              ),
            ),
            label: 'التقارير',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: const Icon(
                Icons.event_available,
                size: 25.0,
              ),
            ),
            label: 'الأحداث',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: const Icon(
                Icons.transfer_within_a_station,
                size: 25.0,
              ),
            ),
            label: 'نقل الطلاب',
          ),
        ],
      ),
    );
  }

  final MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationMenu(context, controller),
        body: Obx(() {
          return IndexedStack(
            index: controller.tabIndex.value,
            children: [
              const AdminScreen(),
              GetComplaints(),
              AddReport(),
              AddEvents(),
              TransferStudentsRequests(),
             //NotificationTest(),
            ],
          );
        }),
      ),
    );
  }
}
