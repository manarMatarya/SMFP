import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/teacher/logic/teacher_controller_basic.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class NotificationTest extends StatefulWidget {
  NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  TeacherControllerBasic controller = Get.put(TeacherControllerBasic(), permanent: true);
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var currentParent;
  bool keyboardOpen = false;
  getParents()async{
    await controller.allParents();
  }

  @override
  void initState() {
    getParents();
    super.initState();
  }

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
                          text: "ارسال اشعار",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                     
                      
                        GetX<TeacherControllerBasic>(builder: (controller) {
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
                        items: controller.allParent.map((parent) {
                          return DropdownMenuItem(
                            value: parent,
                            child: Text(
                              parent.name,
                              style: const TextStyle(
                                  color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            currentParent = value;
                          });
                        },
                            );
                          }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextUtils(
                          fontSize: 18,
                          text: 'عنوان ',
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
                            fillColor: Colors.brown[100],
                            contentPadding: const EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextUtils(
                          fontSize: 18,
                          text: 'محتوى ',
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
                          minLines: 5,
                          maxLines: 10,
                          controller: contentController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.brown[100],
                            contentPadding: const EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
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
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
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
                  pressed: () {
                   
                  },
                  text: 'ارسال',
                ),
              ),
      ),
    );
  }
}
