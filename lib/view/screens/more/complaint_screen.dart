import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/more_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

// ignore: must_be_immutable
class ComplaintScreen extends StatelessWidget {
  ComplaintScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  MoreController controller = Get.put(MoreController());
  void clearText() {
    titleController.clear();
    contentController.clear();
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
                      text: "تقديم شكوى ",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 60,
                      child: Image.asset('assets/images/support.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextUtils(
                      fontSize: 16,
                      text: ' عنوان الشكوى',
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
                      height: 20,
                    ),
                    TextUtils(
                      fontSize: 16,
                      text: 'محتوى الشكوى',
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    contentItem(
                      line: 10,
                      control: contentController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MainButton(
                      text: 'تقديم الشكوى ',
                      pressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.addComplaint(
                            title: titleController.value.text,
                            content: contentController.value.text,
                          );
                          clearText();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}

Widget contentItem({
  required int line,
  required var control,
}) {
  String msg = '';
  return Material(
    borderRadius: BorderRadius.circular(10),
    child: TextFormField(
      validator: (value) {
        if (value.toString().isEmpty) {
          msg = 'من فضلك املأ عنوان ومحتوى الشكوى';
          Get.snackbar(
            'خطأ',
            msg,
            backgroundColor: theme.mainColor,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return '';
        } else {
          return null;
        }
      },
      minLines: line,
      maxLines: 12,
      controller: control,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFCA870).withOpacity(0.3),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFFFCA870).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFFFCA870).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFFFCA870).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFFFCA870).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
