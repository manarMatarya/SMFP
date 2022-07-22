import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/utiles/theme.dart';

class AdminInfoCard extends StatelessWidget {
  const AdminInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: theme.mainColor,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 600,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(150),
                topLeft: Radius.circular(150),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 25,
          right: 25,
          height: 200,
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GetX<AdminController>(
                builder: ((controller) {
                  return controller.loadingInfo.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: theme.mainColor,
                            backgroundColor: Colors.grey[300],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.currentAdmin.value.schoolName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'مدير المدرسة :  ' +
                                  controller.currentAdmin.value.adminName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: theme.mainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
