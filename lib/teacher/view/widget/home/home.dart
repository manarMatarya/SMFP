import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/utiles/theme.dart';

class TeacherInfoCard extends StatelessWidget {
  const TeacherInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
              )),
        ),
      ),
      Positioned(
        top: 30,
        left: 25,
        right: 25,
        height: MediaQuery.of(context).size.height * .3,
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GetX<TeacherControllerBasic>(
              builder: ((controller) {
                return controller.loadingInfo.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: theme.mainColor,
                          backgroundColor: Colors.grey[300],
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: CircleAvatar(
                                radius: 45.0,
                                backgroundImage: NetworkImage(
                                  controller.currentTeacher.value.image,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              controller.currentTeacher.value.name,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'معلم ' + controller.currentTeacherSubject,
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
      )
    ]);
  }
}
