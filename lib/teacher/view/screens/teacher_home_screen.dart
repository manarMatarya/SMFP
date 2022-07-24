import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/auth_controller.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/screens/add_marks.dart';
import 'package:smfp/teacher/view/screens/add_homework.dart';
import 'package:smfp/teacher/view/screens/chat_screen.dart';
import 'package:smfp/teacher/view/widget/home/home.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/main/children_screen.dart';
import 'package:smfp/view/widgets/main_card.dart';

// ignore: must_be_immutable
class TeacherHomeScreen extends StatefulWidget {
  TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  TeacherControllerBasic controller = Get.put(TeacherControllerBasic());
  AuthController authController = Get.put(AuthController());

  getInfo() async {
    await controller.getTeacherInfo();

    controller.classes.value = [];
    await controller.getClasses();
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
                  const TeacherInfoCard(),
                  Positioned(
                    top: 320,
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
                            Get.to(() => const AddMarks());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/marks.png',
                            name: 'ادخال الدرجات',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AddHomework());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/homework.png',
                            name: 'اضافة واجبات',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(TeacherChatScreen());
                          },
                          child: buildTeacherCard(
                            image: 'assets/images/chat.png',
                            name: 'الرسائل',
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
