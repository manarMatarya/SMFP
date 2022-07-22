import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/skelton.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class GetComplaints extends StatefulWidget {
  GetComplaints({Key? key}) : super(key: key);

  @override
  State<GetComplaints> createState() => _GetComplaintsState();
}

class _GetComplaintsState extends State<GetComplaints> {
  AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    controller.parents.value = [];
    controller.complaints.value = [];
    controller.getComplaint();
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
                 
                        text: "عرض الشكاوي",
                 
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetX<AdminController>(
                        builder: ((controller) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return controller.loadingComplaint.value
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
                                            const HomeCardSkelton(),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 16),
                                      ),
                                    )
                                  : controller.complaints.isEmpty
                                      ? const Center(
                                          child:
                                              Text('لم يتم اضافة واجبات بعد'),
                                        )
                                      : buildComplaintsItems(
                                          content: controller
                                              .complaints[index].content,
                                          parent: controller.parents[index],
                                          title: controller
                                              .complaints[index].title,
                                        );
                            },
                            itemCount: controller.complaints.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          );
                        }),
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

Widget buildComplaintsItems(
    {required String content, required String title, required String parent}) {
  return Card(
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)][100],
    //elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                overflow: TextOverflow.visible,
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'من ' + parent,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                overflow: TextOverflow.visible,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class HomeCardSkelton extends StatelessWidget {
  const HomeCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Skeleton(
      width: double.infinity,
      height: 100,
    );
  }
}
