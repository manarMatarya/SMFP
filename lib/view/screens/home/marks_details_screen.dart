import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class MarksDetailsScreen extends StatelessWidget {
  String course = '';
  MarksDetailsScreen({Key? key, required this.course}) : super(key: key);
  ExamController controller = Get.put(ExamController(), permanent: true);

  double grade = 0.0;
  double totalGrade = 0.0;
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
                        text: 'درجات ' + course,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetX<ExamController>(builder: ((controller) {
                        List exams = [];
                        for (int i = 0;
                            i < controller.marks[course].length;
                            i++) {
                          if (controller.marks[course][i].result != 0) {
                            exams.add(controller.marks[course][i]);
                          }
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: exams.length,
                          itemBuilder: (context, index) {
                            grade += exams[index].result;
                            totalGrade += exams[index].total;
                            return listItem(
                                name: exams[index].name,
                                result: exams[index].result,
                                total: exams[index].total,
                                grade: exams[index].grade);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 1,
                              color: Colors.black,
                            );
                          },
                        );
                      })),
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

  Widget listItem(
      {required String name,
      required double result,
      required double total,
      required String grade}) {
    return ListTile(
      leading: const Icon(
        Icons.library_books,
        color: theme.mainColor,
      ),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: ListTile(
        title: Text(
          grade,
          style: const TextStyle(
              color: theme.secondaryColor, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '$total / $result',
          style: const TextStyle(
              color: theme.secondaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
