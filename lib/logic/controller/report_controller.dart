import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/model/report_model.dart';

class ReportsController extends GetxController {
  ChildrenController childrenController = Get.put(ChildrenController());
  final CollectionReference _reportCollectionRef =
      FirebaseFirestore.instance.collection('Report');

  final reports = [].obs;
  final currentreport = ReportModel('', '', '', '', '').obs;
  ReportsController() {
    reports.value = [];
    getReports();
  }

  getReports() async {
    try {
      await _reportCollectionRef
          .where('student_id',
              isEqualTo: childrenController.currentStudent.value.id)
          .get()
          .then(
        (value) async {
          for (int i = 0; i < value.docs.length; i++) {
            reports.add(ReportModel.fromJson(value.docs[i].data()));
          }
        
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
