import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/model/exam_model.dart';
import 'package:smfp/model/semester_model.dart';
import 'package:smfp/shared/db_shared.dart';

class ExamController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());
  final CollectionReference _subjectCollectionRef =
      FirebaseFirestore.instance.collection('Subject');
  final CollectionReference _examCollectionRef =
      FirebaseFirestore.instance.collection('Exam');

  final CollectionReference _classCollectionRef =
      FirebaseFirestore.instance.collection('Class');

  final CollectionReference _resultCollectionRef =
      FirebaseFirestore.instance.collection('ExamResult');
  final exams = [].obs;
  final semesters = [].obs;
  final marks = {}.obs;
  final weekScheduale = {}.obs;
  var loadingMarks = false.obs;
  var loadingExams = false.obs;
  dynamic currentSemester = SemesterModel('', '').obs;

  getExams({required String examType}) async {
    Future.delayed(const Duration(milliseconds: 100), () {
      marks.value = {};
      exams.value = [];
    });
    loadingExams.value = true;
    try {
      await _classCollectionRef
          .where('id',
              isEqualTo: childrenController.currentStudent.value.class_id)
          .get()
          .then(
        (value) {
          List subjects = value.docs[0]['subjects'];
          // ignore: avoid_function_literals_in_foreach_calls
          subjects.forEach((element) async {
            try {
              await _subjectCollectionRef
                  .where('id', isEqualTo: element)
                  .get()
                  .then(
                (value) async {
                  await _examCollectionRef
                      .where('subject_id', isEqualTo: element)
                      .where('exam_type', isEqualTo: examType)
                    //  .where('semester_id', isEqualTo: currentSemester.value.id)
                      .get()
                      .then(
                    (value1) {
                      var exam = ExamModel.fromJson(value1.docs[0].data());

                      var examsMap = {value.docs[0]['name']: exam};
                      exams.add(examsMap);
                    },
                  );
                },
              );
            } catch (e) {
              // ignore: avoid_print
              print('no subjects');
            }
          });
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print('error when found class');
    }
    Future.delayed(const Duration(seconds: 2), () {
      loadingExams.value = false;
    });
  }

  getMarks() async {
    loadingMarks.value = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      marks.value = {};
      exams.value = [];
    });

    try {
      await _classCollectionRef
          .where('id',
              isEqualTo: childrenController.currentStudent.value.class_id)
          .get()
          .then(
        (value) {
          List subjects = value.docs[0]['subjects'];

          // ignore: avoid_function_literals_in_foreach_calls
          subjects.forEach((element) async {
            try {
              await _subjectCollectionRef
                  .where('id', isEqualTo: element)
                  .get()
                  .then(
                (value) async {
                  await _examCollectionRef
                      .where('subject_id', isEqualTo: element)
                      .where('semester_id', isEqualTo: currentSemester.value.id)
                      .get()
                      .then((value1) async {
                    var exam = ExamModel.fromJson(value1.docs[0].data());

                    var examsMap = {value.docs[0]['name']: exam};
                    exams.add(examsMap);
                    var examModel = [];
                    for (int i = 0; i < value1.docs.length; i++) {
                      await _resultCollectionRef.get().then((value2) {
                        for (int j = 0; j < value2.docs.length; j++) {
                          if ((value1.docs[i]['id'] ==
                                  value2.docs[j]['exam_id']) &&
                              (childrenController.currentStudent.value.id ==
                                  value2.docs[j]['student_id'])) {
                            ExamModel model =
                                ExamModel.fromJson(value1.docs[i].data());

                            model.result = value2.docs[j]['result'].toDouble();
                            model.total = value2.docs[j]['total'].toDouble();
                            model.grade = value2.docs[j]['grade'].toString();
                            examModel.add(model);
                            marks[value.docs[0]['name']] = examModel;
                          }
                        }
                      });
                    }
                  });
                },
              );
            } catch (e) {
              // ignore: avoid_print
              print('no subjects');
            }
          });
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print('error when found class');
    }
    Future.delayed(const Duration(seconds: 2), () {
      loadingMarks.value = false;
    });
  }

  getSemesters() async {
    try {
      await DBReference.semesterCollectionRef
          .orderBy('id', descending: true)
          .get()
          .then(
        (value) {
          for (int i = 0; i < value.docs.length; i++) {
            semesters.add(
              SemesterModel.fromJson(
                value.docs[i].data(),
              ),
            );
          }
          currentSemester.value = semesters[0];
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  ExamController() {
    semesters.value = [];
    getSemesters();
    // marks.value = {};
    // getMarks();
  }
}
