import 'package:get/get.dart';
import 'package:smfp/logic/controller/auth_controller.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/model/attendance_model.dart';
import 'package:smfp/shared/db_shared.dart';

class HomeController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());
  AuthController authController = Get.put(AuthController());

  final weekScheduale = {}.obs;
  final attendanceModel = [].obs;

  final schoolsModel = [].obs;

  HomeController() {
    weekScheduale.value = {};
    attendanceModel.value = [];

    getWeekSchedual();
    getAttendance();
  }

  getWeekSchedual() async {
    try {
      await DBReference.weekSchedualeCollectionRef
          .where('class_id',
              isEqualTo: childrenController.currentStudent.value.class_id)
          .get()
          .then(
        (value) async {
          List days = [
            'السبت',
            'الأحد',
            'الاثنين',
            'الثلاثاء',
            'الأربعاء',
            'الخميس'
          ];
          // ignore: avoid_function_literals_in_foreach_calls
          days.forEach(
            (element) async {
              List subjects = [];

              for (int i = 0; i < value.docs[0][element].length; i++) {
                await DBReference.subjectCollectionRef
                    .where('id', isEqualTo: value.docs[0][element][i])
                    .get()
                    .then(
                  (value1) {
                    subjects.add(value1.docs[0]['name']);
                  },
                );
              }
              weekScheduale[element] = subjects;
            },
          );
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getAttendance() async {
    try {
      await DBReference.attendanceCollectionRef
          .where('student_id',
              isEqualTo: childrenController.currentStudent.value.id)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          attendanceModel.add(AttendanceModel.fromJson(value.docs[i].data()));
        }
        update();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
