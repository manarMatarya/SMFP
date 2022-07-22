import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/report_controller.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/report/report_list.dart';
import 'package:smfp/view/widgets/text_utils.dart';

// ignore: must_be_immutable
class ReportScreen extends StatelessWidget {
   ReportScreen({Key? key}) : super(key: key);

  ReportsController controller = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    TextUtils(
                      text: "التقارير",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  const ReportList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


