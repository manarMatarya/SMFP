// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/model/school_model.dart';
import 'package:smfp/utiles/theme.dart';

class MoreController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());
  final CollectionReference _complaintCollectionRef =
      FirebaseFirestore.instance.collection('Complaint');
  final CollectionReference _addStudentCollectionRef =
      FirebaseFirestore.instance.collection('AddStudent');

  final CollectionReference _schoolCollectionRef =
      FirebaseFirestore.instance.collection('School');

  final CollectionReference _transferCollectionRef =
      FirebaseFirestore.instance.collection('TransferStudent');

  final schoolsModel = [].obs;
  final allSchoolsModel = [].obs;

  final currentSchool = SchoolModel('', '', '', '', '', '', '').obs;
  MoreController() {
    schoolsModel.value = [];
    allSchoolsModel.value = [];

    getAllSchools();

    getSchools();
  }

  addStudent(
      {required String name,
      required String schoolId,
      required var images}) async {
    try {
      await _addStudentCollectionRef.add({
        'name': name,
        'school_id': schoolId,
        'father_identity': images[0],
        'birth_certificate': images[1],
        'vaccination card': images[2],
      }).then((value) => Get.snackbar(
            'تم!',
            'تم تقديم طلب تسجيل الطفل , وسيتم الاطلاع عليه من قبل المدرسة',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getSchools() async {
    try {
      await _schoolCollectionRef
          .where('address',
              isEqualTo: childrenController.currentParent.value.address)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          print(value.docs.length);
          print('####################3');
          print(value.docs[i]['id']);
      //    print(childrenController.currentStudent.value.school_id);

          if (value.docs[i]['id'] !=
              childrenController.currentStudent.value.school_id) {
            schoolsModel.add(SchoolModel.fromJson(value.docs[i].data()));
          } else {
            currentSchool.value = SchoolModel.fromJson(value.docs[i].data());
        }
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getAllSchools() async {
    try {
      await _schoolCollectionRef
          .where('address',
              isEqualTo: childrenController.currentParent.value.address)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          allSchoolsModel.add(SchoolModel.fromJson(value.docs[i].data()));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addComplaint({required String title, required String content}) async {
    try {
      await _complaintCollectionRef.add({
        'parent_id': childrenController.currentStudent.value.parent_id,
        'school_id': childrenController.currentStudent.value.school_id,
        'title': title,
        'content': content
      }).then((value) => Get.snackbar(
            'تم!',
            'تم رفع الشكوى لادارة المدرسة للاطلاع عليها',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  transferStudent(
      // ignore: non_constant_identifier_names
      {required String to_school,
      required String average,
      required String reason}) async {
    try {
      await _transferCollectionRef.add({
        'name': childrenController.currentStudent.value.id,
        'current_school_id': childrenController.currentStudent.value.school_id,
        'grade': childrenController.currentStudent.value.grade,
        'average': average,
        'to_school_id': to_school,
        'reason': reason
      }).then((value) => Get.snackbar(
            'تم!',
            'تم تقديم طلب نقل الطالب , ستقوم المدرسة بالاطلاع عليه قريبا',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
