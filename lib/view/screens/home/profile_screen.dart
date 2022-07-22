import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/main/children_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  ChildrenController controller = Get.put(ChildrenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        end: const Alignment(0.0, -1),
                        begin: const Alignment(0.0, 0.6),
                        colors: [
                          theme.mainColor,
                          theme.mainColor.withOpacity(0.8),
                        ],
                      )),
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
                    top: 80,
                    left: 20,
                    right: 20,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
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
                                      controller.currentStudent.value.image),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                controller.currentStudent.value.name,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'الصف ' + controller.currentStudent.value.grade,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: theme.mainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 380,
                    left: 20,
                    right: 20,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          //  height: 75,
                          child: Column(
                            children: [
                              customRow(
                                icon: const Icon(
                                  Icons.perm_identity,
                                  color: theme.mainColor,
                                ),
                                variable: controller.currentStudent.value.id,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              customRow(
                                icon: const Icon(
                                  Icons.cake_outlined,
                                  color: Color.fromRGBO(255, 171, 64, 1),
                                ),
                                variable:
                                    controller.currentStudent.value.birthday,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              customRow(
                                icon: const Icon(
                                  Icons.family_restroom,
                                  color: Color.fromRGBO(240, 98, 146, 1),
                                ),
                                variable:
                                    controller.currentStudent.value.gender,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              customRow(
                                icon: const Icon(
                                  Icons.location_city_outlined,
                                  color: Colors.blue,
                                ),
                                variable: controller.stdSchool.value,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              customRow(
                                icon: const Icon(
                                  Icons.room,
                                  color: theme.secondaryColor,
                                ),
                                variable: controller.stdClass.value,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 680,
                    left: 20,
                    right: 20,
                    height: MediaQuery.of(context).size.height / 10.5,
                    child: InkWell(
                      onTap: () => Get.off(() => ChildrenScreen()),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: SizedBox(
                            width: double.infinity,
                            //  height: 70,
                            child: Text(
                              'انتقال الى صفحة الأبناء',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: theme.mainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
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

  Widget customRow({required Icon icon, required String variable}) {
    return Row(children: [
      icon,
      const SizedBox(width: 20),
      Text(
        variable,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    ]);
  }
}
