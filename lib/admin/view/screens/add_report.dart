import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/teacher/view/screens/add_notification.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddReport extends StatefulWidget {
  AddReport({Key? key}) : super(key: key);

  @override
  State<AddReport> createState() => _AddReportState();
}

List subjects = [];
List status = [];

class _AddReportState extends State<AddReport> {
  AdminController controller = Get.put(AdminController(), permanent: true);
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var currentClass;
  var currentStudent;
  bool keyboardOpen = false;

  @override
  Widget build(BuildContext context) {
    keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextUtils(
                          text: "ارسال تقرير",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'الشعبة : ',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child:
                                  GetX<AdminController>(builder: (controller) {
                                return DropdownButtonFormField(
                                  elevation: 2,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'يجب تحديد الشعبة';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  items: controller.classes.map((clas) {
                                    return DropdownMenuItem(
                                      value: clas,
                                      child: Text(
                                        clas.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      currentClass = value;
                                      controller.students.value = [];
                                      controller.getStudents(
                                          classId: currentClass.id);
                                    });
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'الطالب/ة : ',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child:
                                  GetX<AdminController>(builder: (controller) {
                                return DropdownButtonFormField(
                                  elevation: 2,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'يجب تحديد الطالب';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  items: controller.students.map((student) {
                                    return DropdownMenuItem(
                                      value: student,
                                      child: Text(
                                        student.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      currentStudent = value;
                                    });
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextUtils(
                          fontSize: 18,
                          text: ' عنوان التقرير',
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              Get.snackbar(
                                'خطأ',
                                'من فضلك املأ عنوان التقرير',
                                backgroundColor: theme.mainColor,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return '';
                            } else {
                              return null;
                            }
                          },
                          controller: titleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFCA870).withOpacity(0.3),
                            contentPadding: const EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFCA870).withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFCA870).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFCA870).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFCA870).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextUtils(
                          fontSize: 18,
                          text: 'محتوى التقرير',
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              Get.snackbar(
                                'خطأ',
                                'من فضلك املأ محتوى التقرير',
                                backgroundColor: theme.mainColor,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return '';
                            } else {
                              return null;
                            }
                          },
                          minLines: 8,
                          maxLines: 10,
                          controller: contentController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFCA870).withOpacity(0.3),
                            contentPadding: const EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFCA870).withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xFFFCA870).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFCA870).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFCA870).withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: keyboardOpen
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MainButton(
                  pressed: () async {
                    controller.addReport(
                      content: contentController.text,
                      title: titleController.text,
                      studentId: currentStudent.id,
                    );
                    List<String>? tokents = await controller.getToken();

                    tokents.forEach((element) {
                      PushNotification.instance.sendNotification(
                        title: "تم اضافة تقرير جديد",
                        body: titleController.text,
                        to: element,
                      );
                    });
                  },
                  text: 'ارسال',
                ),
              ),
      ),
    );
  }
}
