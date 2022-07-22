import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/auth_controller.dart';
import 'package:smfp/logic/controller/more_controller.dart';

import 'package:smfp/routes/routes.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/more/report_screen.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);
  AuthController controller = Get.put(AuthController());
  //MoreController moreController = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                       TextUtils(
                        fontSize: 25,
                        text: "المعاملات الادارية",
                   
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.complaintScreen);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Icon(
                              Icons.support_agent_sharp,
                              color: theme.mainColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'تقديم شكوى',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.transferStudentScreen);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Icon(
                              Icons.transfer_within_a_station,
                              color: theme.mainColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'نقل الطالب من المدرسة',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.whoScreen);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Icon(
                              Icons.contact_support_outlined,
                              color: theme.mainColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'من نحن',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          controller.signOutFromApp();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Icon(
                              Icons.logout,
                              color: theme.mainColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'خروج من التطبيق',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
