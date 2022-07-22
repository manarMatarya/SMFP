import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/widget/marks/marks.items.dart';
import 'package:smfp/utiles/theme.dart';

// ignore: must_be_immutable
class StudentList extends StatelessWidget {
  StudentList({Key? key}) : super(key: key);

  final fromKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = [];
  @override
  Widget build(BuildContext context) {
    return GetX<TeacherControllerBasic>(
      builder: ((controller) {
        return controller.studentsLoading.value
            ? Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 104, 103, 103),
                highlightColor: theme.mainColor,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) => examsCardSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
              )
            : controller.students.isEmpty
                ? SizedBox(
                    height: 350,
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
                            'لا يوجد طلاب في الفصل',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : Form(
                    key: fromKey,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.students.length,
                      itemBuilder: ((context, index) {
                        _controllers.add(TextEditingController());
                        return studentItem(
                            add: _controllers[index],
                            image: controller.students[index].image,
                            text: controller.students[index].name);
                      }),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  );
      }),
    );
  }
}
