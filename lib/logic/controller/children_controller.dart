import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smfp/model/event_model.dart';

import 'package:smfp/model/student_model.dart';
import 'package:smfp/model/user_model.dart';
import 'package:smfp/shared/db_shared.dart';

import 'package:smfp/view/screens/main/main_screen.dart';

class ChildrenController extends GetxController {

  final stdClass = ''.obs;
  final stdSchool = ''.obs;
  final studentModel = [].obs;
  var alleventsModel = [];
  var loadingStudent = false.obs;
  final currentStudent = StudentModel('', '', '', '', '', '', '', '', '').obs;
  final currentParent = ParentModel('', '', '', '', '').obs;

  ChildrenController() {
    getParentInfo();
  }

  getStudent() async {
    loadingStudent.value = true;
    try {
      await DBReference.studentCollectionRef
          .where('parent_id', isEqualTo: GetStorage().read('id'))
          .get()
          .then(
        (value) {
          for (int i = 0; i < value.docs.length; i++) {
            studentModel.add(StudentModel.fromJson(value.docs[i].data()));
          }

          update();
        },
      );
      loadingStudent.value = false;
    } catch (e) {
      // ignore: avoid_print
      print("$e :: eror when loading students");
    }
    Future.delayed(const Duration(seconds: 2), () {
            loadingStudent.value = false;

    });
  }

  getCurrentStudent({required String id}) async {
    try {
      await DBReference.studentCollectionRef.where('id', isEqualTo: id).get().then(
        (value) async {
          currentStudent.value = StudentModel.fromJson(value.docs[0].data());
          await DBReference.classCollectionRef
              .where('id', isEqualTo: currentStudent.value.class_id)
              .get()
              .then(
            (value) {
              stdClass.value = value.docs[0]['name'];
            },
          );
          await DBReference.schoolCollectionRef
              .where('id', isEqualTo: currentStudent.value.school_id)
              .get()
              .then(
            (value) {
              stdSchool.value = value.docs[0]['school_name'];
    
            },
          );
          Future.delayed(const Duration(milliseconds: 100), () async {
            alleventsModel = [];
            await getEvents();
            Get.to(() => const MainScreen());
          });
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getParentInfo() async {
    try {
      await DBReference.parentRef
          .where('id', isEqualTo: GetStorage().read('id'))
          .get()
          .then(
        (value) {
          currentParent.value = ParentModel.fromJson(
            value.docs[0].data(),
          );
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  getEvents() async {
    try {
      await DBReference.eventsCollectionRef
          .where('school_id', isEqualTo: currentStudent.value.school_id)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          alleventsModel.add(EventModel.fromJson(value.docs[i].data()));
        }
        update();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
