import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/model/homework_model.dart';
import 'package:smfp/shared/db_shared.dart';

class HomeworkController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());

  final homeworks = [].obs;
  final subjectName = ''.obs;
  var loadingHomework = false.obs;
  final currentHomework = HomeworkModel('', '', '', '', '', '').obs;

  getHomeworks() async {
    loadingHomework.value = true;
    try {
      await DBReference.homeworkCollectionRef
          .where('class_id',
              isEqualTo: childrenController.currentStudent.value.class_id)
          .get()
          .then(
        (value) async {
          for (int i = 0; i < value.docs.length; i++) {
            try {
              await DBReference.subjectCollectionRef
                  .where('id', isEqualTo: value.docs[i]['subject_id'])
                  .get()
                  .then(
                (value1) async {
                  var homework = HomeworkModel.fromJson(value.docs[i].data());

                  var homeworksMap = {value1.docs[0]['name']: homework};
                  homeworks.add(homeworksMap);
                },
              );
            } catch (e) {
              // ignore: avoid_print
              print('no subject');
            }
          }
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print('error when found class');
      // ignore: avoid_print
      print(e.toString());
    }
    Future.delayed(const Duration(seconds: 2), () {
      loadingHomework.value = false;
    });
  }
}
