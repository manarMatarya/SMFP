import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/logic/controller/more_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class TransferStudentScreen extends StatefulWidget {
  TransferStudentScreen({Key? key}) : super(key: key);

  @override
  State<TransferStudentScreen> createState() => _TransferStudentScreenState();
}

class _TransferStudentScreenState extends State<TransferStudentScreen> {
  final fromKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  TextEditingController avgController = TextEditingController();

  TextEditingController levelController = TextEditingController();

  TextEditingController reasonController = TextEditingController();

  TextEditingController currentSchoolController = TextEditingController();

  TextEditingController toSchoolController = TextEditingController();

  MoreController controller = Get.put(MoreController());
  ChildrenController childrenController = Get.put(ChildrenController());

  var toSchool;
  @override
  void initState() {
    nameController.text = childrenController.currentStudent.value.name;
    levelController.text = childrenController.currentStudent.value.grade;

    avgController.text = '80%';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Form(
                key: fromKey,
                child: Column(
                  children: [
                     TextUtils(
                  
                     
                      text: "نقل الطالب من المدرسة",
                      
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    contentItem(
                      controller: nameController,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: theme.mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    contentItem(
                      controller: avgController,
                      prefixIcon: const Icon(
                        Icons.av_timer_outlined,
                        color: theme.mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    contentItem(
                      controller: levelController,
                      prefixIcon: const Icon(
                        Icons.grading,
                        color: theme.mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetX<MoreController>(
                      builder: ((controller) {
                        return contentItem(
                          hint: controller.currentSchool.value.name,
                          controller: currentSchoolController,
                          prefixIcon: const Icon(
                            Icons.transfer_within_a_station_sharp,
                            color: theme.mainColor,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 3,
                      shadowColor: Colors.grey,
                      child: GetX<MoreController>(builder: (controller) {
                        return DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'من فضلك حدد المدرسة المراد نقل الطالب اليها';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
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
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.school_outlined,
                              color: theme.mainColor,
                            ),
                          ),
                          hint: const Text('المدرسة المراد النقل اليها '),
                          items: controller.schoolsModel.map((school) {
                            return DropdownMenuItem(
                              value: school,
                              child: Text(
                                school.name,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              toSchool = value;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 3,
                      shadowColor: Colors.grey,
                      child: TextFormField(
                        validator: ((value) {
                          if (value.toString().isEmpty) {
                            return 'من فضلك أخبرنا بدواعي نقل الطالب';
                          } else {
                            return null;
                          }
                        }),
                        minLines: 1,
                        maxLines: 10,
                        textAlignVertical: TextAlignVertical.center,
                        controller: reasonController,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.question_mark,
                              color: theme.mainColor),
                          hintText: 'دواعي النقل',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MainButton(
                      text: 'تقديم الطلب',
                      pressed: () {
                        if (fromKey.currentState!.validate()) {
                          controller.transferStudent(
                              to_school: toSchool.id,
                              average: avgController.text,
                              reason: reasonController.text);
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

contentItem({
  required TextEditingController controller,
  required Icon prefixIcon,
  String hint = '',
}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    elevation: 3,
    shadowColor: Colors.grey,
    child: TextFormField(
      enabled: false,
      minLines: 1,
      maxLines: 10,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      cursorColor: Colors.black,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
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
  );
}
