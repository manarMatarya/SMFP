import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/logic/controller/message_controller.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/main/chat_screen.dart';
import 'package:smfp/view/screens/main/children_screen.dart';
import 'package:smfp/view/widgets/children/children_items.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class TeacherChatScreen extends StatelessWidget {
  TeacherChatScreen({Key? key}) : super(key: key);
  TeacherControllerBasic controller =
      Get.put(TeacherControllerBasic(), permanent: true);
  MessageController messageController =
      Get.put(MessageController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    controller.parents.value = [];
    controller.getChat();
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
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      TextUtils(
                        text: "رسائل أولياء الأمور",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetX<TeacherControllerBasic>(
                        builder: (controller) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return controller.parents.isEmpty
                                ? Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        255, 104, 103, 103),
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
                                    ))
                                : InkWell(
                                    onTap: () {
                                      messageController.teacher =
                                          controller.parents[index];

                                      Get.to(() => const ChatScreen());
                                    },
                                    child: buildParentItems(
                                      image: controller.parents[index].image,
                                      name: controller.parents[index].name,
                                    ),
                                  );
                          },
                          itemCount: controller.parents.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
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

Widget buildParentItems({
  required String image,
  required String name,
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
            Text(
              name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: theme.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
