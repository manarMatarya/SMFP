import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/children/children_items.dart';

class ChildrenList extends StatelessWidget {
  const ChildrenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ChildrenController>(
      builder: (controller) {
        return controller.loadingStudent.value
            ? Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 104, 103, 103),
                highlightColor: theme.mainColor,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) => const NewsCardSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ))
            : controller.studentModel.isEmpty
                ? SizedBox(
                    height: 450,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/nostudent.jpeg',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'لا تمتلك أبناء مسجلين في المدارس',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (() => controller.getCurrentStudent(
                              id: controller.studentModel[index].id,
                            )),
                        child: buildChildItems(
                          image: controller.studentModel[index].image,
                          name: controller.studentModel[index].name,
                        ),
                      );
                    },
                    itemCount: controller.studentModel.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
      },
    );
  }
}
