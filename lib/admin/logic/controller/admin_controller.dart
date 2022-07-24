import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smfp/model/admin_model.dart';
import 'package:smfp/model/class_model.dart';
import 'package:smfp/model/complaint_model.dart';
import 'package:smfp/model/student_model.dart';
import 'package:smfp/model/subject_model.dart';
import 'package:smfp/model/transfer_model.dart';
import 'package:smfp/model/user_model.dart';
import 'package:smfp/shared/db_shared.dart';
import 'package:smfp/teacher/view/screens/add_notification.dart';
import 'package:smfp/utiles/theme.dart';

class AdminController extends GetxController {
  final CollectionReference _adminRef =
      FirebaseFirestore.instance.collection('School');
  final CollectionReference _reportRef =
      FirebaseFirestore.instance.collection('Report');

  final CollectionReference _classRef =
      FirebaseFirestore.instance.collection('Class');
  final CollectionReference _subjectRef =
      FirebaseFirestore.instance.collection('Subject');
  final CollectionReference _studentRef =
      FirebaseFirestore.instance.collection('Student');
  final CollectionReference _complaintRef =
      FirebaseFirestore.instance.collection('Complaint');
  final CollectionReference _parentRef =
      FirebaseFirestore.instance.collection('Parent');

  final CollectionReference _weekSchedualeCollectionRef =
      FirebaseFirestore.instance.collection('WeeklySchedule');

  final CollectionReference _examCollectionRef =
      FirebaseFirestore.instance.collection('Exam');
  final CollectionReference _attendanceRef =
      FirebaseFirestore.instance.collection('Attendance');
  final CollectionReference _eventRef =
      FirebaseFirestore.instance.collection('Event');

  final CollectionReference _transferRef =
      FirebaseFirestore.instance.collection('TransferStudent');

  final currentAdmin = AdminModel('', '', '', '', '', '', '').obs;
  dynamic currentClass = ClassModel('', '').obs;
  var currentDay = 0.obs;
  List tempSubjects = [].obs;

  final classes = [].obs;
  final complaints = [].obs;
  final subjects = [].obs;
  final students = [].obs;
  final parents = [].obs;
  var loadingComplaint = false.obs;
  var loadingInfo = false.obs;
  final studentNames = [].obs;
  final transfers = [].obs;
  var loadingTransfer = false.obs;

  getAdminInfo() async {
    loadingInfo.value = true;
    try {
      await _adminRef
          .where('id', isEqualTo: GetStorage().read('id'))
          .get()
          .then(
        (value) async {
          currentAdmin.value = AdminModel.fromJson(
            value.docs[0].data(),
          );
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

  getClasses() async {
    try {
      await _classRef
          .where('school_id', isEqualTo: currentAdmin.value.id)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          classes.add(ClassModel.fromJson(value.docs[i].data()));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getSubjects() async {
    try {
      await _subjectRef.get().then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          subjects.add(SubjectModel.fromJson(value.docs[i].data()));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addSchedule({classId, day, subjects}) async {
    try {
      await _weekSchedualeCollectionRef
          .where('class_id', isEqualTo: classId)
          .get()
          .then((value) async {
        if (value.docs.length == 1) {
          await _weekSchedualeCollectionRef
              .doc(value.docs[0].id)
              .update({'$day': subjects}).then((value) {
            Get.snackbar(
              'تم',
              'تم حفظ البيانات',
              colorText: Colors.white,
              backgroundColor: theme.mainColor,
            );
          });
        } else {
          await _weekSchedualeCollectionRef
              .add({'class_id': classId, '$day': subjects}).then((value) {
            Get.snackbar(
              'تم',
              'تم حفظ البيانات',
              colorText: Colors.white,
              backgroundColor: theme.mainColor,
            );
          });
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addExam({name, date, examType, semesterId, subjectId, time}) async {
    final collRef = _examCollectionRef;
    DocumentReference docReference = collRef.doc();
    try {
      await docReference.set({
        'name': name,
        'subject_id': subjectId,
        'date': date,
        'exam_type': examType,
        'semester_id': semesterId,
        'time': time
      }).then((value) async {
        await _examCollectionRef
            .doc(docReference.id)
            .update({'id': docReference.id}).then((value) {
          Get.snackbar(
            'تم!',
            'تم اضافة الاختبار بنجاح',
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

  addReport({content, title, studentId}) async {
    DateTime selectedDate = DateTime.now();
    try {
      await _reportRef.add({
        'content': content,
        'title': title,
        'student_id': studentId,
        'school_id': currentAdmin.value.id,
        'date_created': "${selectedDate.toLocal()}".split(' ')[0]
      }).then((value) => Get.snackbar(
            'تم!',
            'تم اضافة التقرير بنجاح',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getComplaint() async {
    loadingComplaint.value = true;
    try {
      await _complaintRef
          .where('school_id', isEqualTo: currentAdmin.value.id)
          .get()
          .then((value) async {
        for (int i = 0; i < value.docs.length; i++) {
          await _parentRef
              .where('id', isEqualTo: value.docs[i]['parent_id'])
              .get()
              .then((value) {
            parents.add(value.docs[0]['name']);
          });
          complaints.add(ComplaintModel.fromJson(value.docs[i].data()));
        }
      });
      loadingComplaint.value = false;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getStudents({classId}) async {
    try {
      await _studentRef
          .where('class_id', isEqualTo: classId)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          students.add(StudentModel.fromJson(value.docs[i].data()));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addAttendance({reason, date, status, studentId}) async {
    try {
      await _attendanceRef.add({
        'date': date,
        'status': status,
        'student_id': studentId,
        'reason': reason,
      }).then((value) => Get.snackbar(
            'تم!',
            'تم حفظ البيانات',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  addEvent({title, date, image}) async {
    try {
      await _eventRef.add({
        'date': date,
        'title': title,
        'image': image,
        'school_id': currentAdmin.value.id,
      }).then((value) => Get.snackbar(
            'تم!',
            'تم حفظ البيانات',
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getTransfer() async {
    loadingTransfer.value = true;
    try {
      await _transferRef
          .where('current_school_id', isEqualTo: currentAdmin.value.id)
          .where('first_accept', isEqualTo: 'no')
          .get()
          .then((value) async {
        for (int i = 0; i < value.docs.length; i++) {
          await _studentRef
              .where('id', isEqualTo: value.docs[i]['name'])
              .get()
              .then((value) {
            studentNames.add(value.docs[0]['name']);
          });
          transfers.add(TransferModel.fromJson(value.docs[i].data()));
        }
      });

      await _transferRef
          .where('to_school_id', isEqualTo: currentAdmin.value.id)
          .where('second_accept', isEqualTo: 'no')
          .get()
          .then((value) async {
        for (int i = 0; i < value.docs.length; i++) {
          await _studentRef
              .where('id', isEqualTo: value.docs[i]['name'])
              .get()
              .then((value) {
            studentNames.add(value.docs[0]['name']);
          });
          transfers.add(TransferModel.fromJson(value.docs[i].data()));
        }
      });
      Future.delayed(const Duration(seconds: 2), () {
        loadingTransfer.value = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  currentSchoolAccept(String id, current, to) async {
    if (currentAdmin.value.id == current) {
      await _transferRef
          .doc(id)
          .update({'first_accept': 'yes'}).then((value) async {
        Get.snackbar(
          'تم!',
          'تم الموافقة على الطلب',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: theme.mainColor,
          colorText: Colors.white,
        );
        List<String>? tokents = await getToken();

        tokents.forEach((element) {
          PushNotification.instance.sendNotification(
            title: 'تم الموافقة ',
            body: 'وافقت مدرسة ' +
                currentAdmin.value.schoolName +
                ' على طلب النقل',
            to: element,
          );
        });
      });
    } else if (currentAdmin.value.id == to) {
      await _transferRef
          .doc(id)
          .update({'second_accept': 'yes'}).then((value) async {
        await _studentRef
            .doc(id)
            .update({'school_id': currentAdmin.value.id}).then((value) async {
          Get.snackbar(
            'تم!',
            'تم الموافقة على الطلب',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
          );
          List<String>? tokents = await getToken();

          tokents.forEach((element) {
            PushNotification.instance.sendNotification(
              title: 'تم الموافقة ',
              body: 'وافقت مدرسة ' +
                  currentAdmin.value.schoolName +
                  ' على طلب النقل',
              to: element,
            );
          });
        });
      });
    }
  }

  deletEDocument({required String id}) async {
    await _transferRef.doc(id).delete().then((value) async {
      Get.snackbar(
        'تم!',
        'تم رفض الطلب',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: theme.mainColor,
        colorText: Colors.white,
      );
      List<String>? tokents = await getToken();

      tokents.forEach((element) {
        PushNotification.instance.sendNotification(
          title: 'تم الرفض ',
          body: 'رفضت مدرسة ' + currentAdmin.value.schoolName + ' طلب النقل',
          to: element,
        );
      });
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
}
