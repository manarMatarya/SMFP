import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/admin/view/screens/add_attendance.dart';
import 'package:smfp/admin/view/screens/add_exam.dart';
import 'package:smfp/admin/view/screens/new_schedule.dart';
import 'package:smfp/admin/view/widget/home/admin_info_card.dart';
import 'package:smfp/logic/controller/auth_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/main/children_screen.dart';
import 'package:smfp/view/widgets/main_card.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminController controller = Get.put(AdminController(), permanent: true);
  AuthController authController = Get.put(AuthController(), permanent: true);

var fbm =FirebaseMessaging.instance;
  @override
  void initState() {
    fbm.getToken().then((token) {
      print("==============");
      print(token);
      print("==============");
    });
    // TODO: implement initState
    super.initState();


  }
 

  getInfo() async {
    await controller.getAdminInfo();
    controller.classes.value = [];
    await controller.getClasses();
    controller.subjects.value = [];
    await controller.getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    int _value = 0;
    getInfo();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.mainColor,
          elevation: 0,
          leading: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: theme.secondaryColor,
              ),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("تسجيل خروج"),
                value: 2,
              )
            ],
            onSelected: (int value) {
              setState(() {
                _value = value;
              });

              if (_value == 2) {
                authController.signOutFromApp();
              }
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const AdminInfoCard(),
                  Positioned(
                    top: 240,
                    left: 40,
                    right: 40,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const AddScheduale());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/scheduals.png',
                            name: 'جداول الحصص',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => AddExam());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/marks.png',
                            name: 'اختبارات',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => AddAttendance());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/attendance.png',
                            name: 'الحضور والغياب',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ChildrenScreen());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/family.png',
                            name: 'دخول كولي أمر',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
