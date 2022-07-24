import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smfp/model/class_model.dart';
import 'package:smfp/model/exam_model.dart';
import 'package:smfp/model/student_model.dart';

import 'package:smfp/model/teacher_model.dart';
import 'package:smfp/model/user_model.dart';
import 'package:smfp/shared/db_shared.dart';
import 'package:smfp/utiles/theme.dart';

class TeacherControllerBasic extends GetxController {
  final currentTeacher = TeacherModel('', '', '', '', '', '', []).obs;
  final currentExam = ExamModel('', '', '', '', '', '', 0.0, 0.0, '', '').obs;
  String currentTeacherSubject = '';
  final classes = [].obs;
  dynamic currentClass = ClassModel('', '').obs;

  final exams = [].obs;
  final students = [].obs;
  final parents = [].obs;
  var isLoading = false.obs;
  var loadingInfo = false.obs;
  var studentsLoading = false.obs;

  getTeacherInfo() async {
    loadingInfo.value = true;
    try {
      await DBReference.teacherRef
          .where('id', isEqualTo: GetStorage().read('id'))
          .get()
          .then(
        (value) async {
          await DBReference.subjectCollectionRef
              .where('id', isEqualTo: value.docs[0]['subject_id'])
              .get()
              .then((value1) {
            currentTeacherSubject = value1.docs[0]['name'];
            currentTeacher.value = TeacherModel.fromJson(
              value.docs[0].data(),
            );
          });
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    Future.delayed(const Duration(seconds: 2), () {
      loadingInfo.value = false;
    });
  }

  addHomework({
    required String title,
    required String content,
    required String date,
    required String classId,
  }) async {
    final collRef = DBReference.homeworkCollectionRef;
    DocumentReference docReference = collRef.doc();
    try {
      await docReference.set({
        'title': title,
        'subject_id': currentTeacher.value.subjectId,
        'class_id': classId,
        'content': content,
        'date': date,
      }).then((value) async {
        await DBReference.homeworkCollectionRef
            .doc(docReference.id)
            .update({'id': docReference.id}).then((value) {
          Get.snackbar(
            'تم!',
            'تم اضافة الواجب بنجاح',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          );
        });
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  // getClasses() async {
  //   try {
  //     await DBReference.classCollectionRef
  //         .where('school_id', isEqualTo: currentTeacher.value.schoolId)
  //         .get()
  //         .then((value) {
  //       for (int i = 0; i < value.docs.length; i++) {
  //         classes.add(ClassModel.fromJson(value.docs[i].data()));
  //       }
  //     });
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e.toString());
  //   }
  // }
  getClasses() async {
    // ignore: avoid_function_literals_in_foreach_calls
    currentTeacher.value.classes.forEach((element) async {
      try {
        await DBReference.classCollectionRef
            .where('id', isEqualTo: element)
            .get()
            .then((value) {
          classes.add(ClassModel.fromJson(value.docs[0].data()));
        });
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    });
  }

  Future<List<String>> getToken() async {
    List<String> tokens = [];
    try {
      tokens = await FirebaseFirestore.instance
          .collection('token')
          .where("role", isEqualTo: "parent")
          .get()
          .then((value) async {
        for (var doc in value.docs) {
          tokens.add(doc["token"]);
        }
        return tokens;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
    return tokens;
  }

  getExams(String examType) async {
    isLoading.value = true;
    try {
      await DBReference.examCollectionRef
          .where('subject_id', isEqualTo: currentTeacher.value.subjectId)
          .where('exam_type', isEqualTo: examType)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          exams.add(ExamModel.fromJson(value.docs[i].data()));
        }
      });
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getStudents() async {
    studentsLoading.value = true;
    try {
      await DBReference.studentCollectionRef
          .where('class_id', isEqualTo: currentClass.id)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          students.add(StudentModel.fromJson(value.docs[i].data()));
        }
      });

      Future.delayed(const Duration(seconds: 2), () {
        studentsLoading.value = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addExamResult({result, studentId, total}) async {
    double res = double.parse(result);
    double score = double.parse(total);
    String grade = '';
    double avg = (res / score) * 100;
    if (avg >= 90) {
      grade = 'ممتاز';
    } else if (avg >= 80 && avg < 90) {
      grade = 'جيد جدا';
    } else if (avg >= 70 && avg < 80) {
      grade = 'جيد';
    } else if (avg >= 60 && avg < 70) {
      grade = 'متوسط';
    } else if (avg >= 50 && avg < 60) {
      grade = 'مقبول';
    } else {
      grade = 'راسب';
    }
    try {
      await DBReference.resultCollectionRef.doc(currentExam.value.id).set({
        'exam_id': currentExam.value.id,
        'result': res,
        'student_id': studentId,
        'total': score,
        'grade': grade,
      }).then((value) {
        Get.snackbar(
          'تم',
          'تم حفظ الدرجات',
          colorText: Colors.white,
          backgroundColor: theme.mainColor,
        );
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getChat() async {
    var temp = [];
    try {
      await DBReference.messageRef
          .where('reciever', isEqualTo: currentTeacher.value.phone)
          .get()
          .then((value) async {
        for (int i = 0; i < value.docs.length; i++) {
          await DBReference.parentRef
              .where('phone', isEqualTo: value.docs[i]['sender'])
              .get()
              .then((parent) {
            for (int j = 0; j < parent.docs.length; j++) {
              temp.add(ParentModel.fromJson(parent.docs[j].data()));
            }
          });
        }
      });
      final jsonList = temp.map((item) => jsonEncode(item)).toList();
      final uniqueJsonList = jsonList.toSet().toList();

      final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();

      for (var element in result) {
        parents.add(ParentModel.fromJson(element));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  final allParent = [].obs;

  allParents() async {
    try {
      await DBReference.parentRef.get().then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          allParent.add(ParentModel.fromJson(value.docs[i].data()));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
