import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/model/teacher_model.dart';

class TeacherController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());
  final CollectionReference _classCollectionRef =
      FirebaseFirestore.instance.collection('Class');
  final CollectionReference _subjectCollectionRef =
      FirebaseFirestore.instance.collection('Subject');
  final CollectionReference _teacherCollectionRef =
      FirebaseFirestore.instance.collection('Teacher');

  final teachers = [].obs;
  var loadingTeacher = false.obs;

  getTeachers() async {
    loadingTeacher.value = true;
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
                  await _teacherCollectionRef
                      .where('subject_id', isEqualTo: element)
                      .get()
                      .then(
                    (value1) {
                      var teacher =
                          TeacherModel.fromJson(value1.docs[0].data());

                      var teachersMap = {value.docs[0]['name']: teacher};
                      teachers.add(teachersMap);
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
      loadingTeacher.value = false;
    } catch (e) {
      // ignore: avoid_print
      print('error when found class');
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
