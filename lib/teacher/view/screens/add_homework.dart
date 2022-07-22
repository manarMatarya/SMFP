import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/teacher/view/screens/add_notification.dart';
import 'package:smfp/teacher/view/widget/homework/homework_items.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddHomework extends StatefulWidget {
  const AddHomework({Key? key}) : super(key: key);

  @override
  State<AddHomework> createState() => _AddHomeworkState();
}

class _AddHomeworkState extends State<AddHomework> {
  var formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  TeacherControllerBasic controller = Get.put(TeacherControllerBasic());

  void clearText() {
    titleController.clear();
    contentController.clear();
    dateController.clear();
  }

  @override
  void dispose() {
    clearText();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextUtils(
                        text: "اضافة واجب جديد",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextUtils(
                        fontSize: 16,
                        text: 'حدد الصف',
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ClassField(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextUtils(
                        fontSize: 16,
                        text: ' عنوان الدرس',
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      contentItem(
                        line: 1,
                        control: titleController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextUtils(
                        fontSize: 16,
                        text: 'تاريخ تسليم الواجب',
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: contentItem(
                            line: 1, control: dateController, enabled: false),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextUtils(
                        fontSize: 16,
                        text: ' تفاصيل الواجب',
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      contentItem(
                        line: 5,
                        control: contentController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
        floatingActionButton: MainButton(
          text: 'اضافة الواجب',
          pressed: () async {
            if (formKey.currentState!.validate()) {
              controller.addHomework(
                title: titleController.text,
                content: contentController.text,
                date: dateController.text,
                classId: controller.currentClass.id,
              );
              List<String>? tokents = await controller.getToken();

              tokents.forEach((element) {
                print("ddddd ${element}");
                PushNotification.instance.sendNotification(
                    title: "${titleController.text}",
                    body: "${contentController.text}",
                    to: element);
                print("fffffffffffffffff");
              });
            }
          },
        ),
      ),
    );
  }
}
