import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/logic/controller/message_controller.dart';
import 'package:smfp/logic/controller/teacher_controller.dart';

import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/main/chat_screen.dart';
import 'package:smfp/view/screens/main/children_screen.dart';
import 'package:smfp/view/widgets/children/children_items.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class TeacherScreen extends StatefulWidget {
  TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  TeacherController controller = Get.put(TeacherController());

  MessageController messageController = Get.put(MessageController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        controller.teachers.value = [];
        controller.getTeachers();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      TextUtils(
                        text: "أسماء المعلمين",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetX<TeacherController>(
                        builder: (controller) {
                          return controller.loadingTeacher.value
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 104, 103, 103),
                                  highlightColor: theme.mainColor,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 8,
                                    itemBuilder: (context, index) =>
                                        const NewsCardSkelton(),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 16),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var course = controller.teachers[index].keys
                                        .toList()
                                        .toString();
                                    return InkWell(
                                      onTap: () {
                                        messageController.teacher =
                                            controller.teachers[index][
                                                course.substring(
                                                    1, course.length - 1)];
                                        
                                        Get.to(() => const ChatScreen());
                                      },
                                      child: buildTeacherItems(
                                        image: controller
                                            .teachers[index][course.substring(
                                                1, course.length - 1)]
                                            .image,
                                        name: controller
                                            .teachers[index][course.substring(
                                                1, course.length - 1)]
                                            .name,
                                        courseName: course.substring(
                                            1, course.length - 1),
                                      ),
                                    );
                                  },
                                  itemCount: controller.teachers.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                );
                        },
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

Widget buildTeacherItems({
  required String image,
  required String name,
  required String courseName,
}) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          children: [
            SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: theme.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  courseName,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: theme.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
