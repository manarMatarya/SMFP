import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/logic/controller/exam_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddExam extends StatefulWidget {
  AddExam({Key? key}) : super(key: key);

  @override
  State<AddExam> createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {
  dynamic subject;
  dynamic examType;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var toTimeController = TextEditingController();

  var nameController = TextEditingController();
  AdminController adminController = Get.put(AdminController(), permanent: true);
  ExamController examController = Get.put(ExamController());

  List<String> examTypes = ['نصفي', 'نهائي', 'شهري'];

  @override
  void dispose() {
    clearText();
    super.dispose();
  }

  void clearText() {
    subject = '';
    examType = '';
    nameController.clear();
    dateController.clear();
    toTimeController.clear();
    timeController.clear();
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay toSelectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, time, controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != time) {
      setState(() {
        time = picked;
        controller.text = time.hour.toString();
      });
    }
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

  final formKey = GlobalKey<FormState>();
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
                          text: "اضافة اختبار",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GetX<ExamController>(builder: (controller) {
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
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
                              prefixIcon: const Icon(
                                Icons.list,
                                color: theme.secondaryColor,
                              ),
                            ),
                            items: controller.semesters.map((semester) {
                              return DropdownMenuItem(
                                value: semester,
                                child: Text(
                                  semester.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              controller.currentSemester.value.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: (value) {
                              setState(() {
                                controller.currentSemester.value = value;
                              });
                            },
                          );
                        }),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            dataTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  '',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '',
                                ),
                              ),
                            ],
                            rows: [
                              DataRow(
                                color: MaterialStateProperty.all<Color>(
                                    theme.mainColor.withOpacity(0.3)),
                                cells: [
                                  const DataCell(
                                    Text(
                                      'المادة',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    GetX<AdminController>(
                                        builder: (controller) {
                                      return SizedBox(
                                        width: 150,
                                        child: DropdownButtonFormField(
                                          validator: (v) {
                                            if (v.toString().isEmpty) {
                                              return '?';
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              subject = val;
                                            });
                                          },
                                          items: controller.subjects.map((sub) {
                                            return DropdownMenuItem(
                                              value: sub,
                                              child: Text(
                                                sub.name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      'نوع الاختبار',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: DropdownButtonFormField(
                                        validator: (v) {
                                          if (v.toString().isEmpty) {
                                            return '?';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            examType = val;
                                          });
                                        },
                                        items: examTypes.map((type) {
                                          return DropdownMenuItem(
                                            value: type,
                                            child: Text(
                                              type,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                color: MaterialStateProperty.all<Color>(
                                    theme.mainColor.withOpacity(0.3)),
                                cells: [
                                  const DataCell(
                                    Text(
                                      'تاريخ الاختبار',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: InkWell(
                                        onTap: () => _selectDate(context),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent))),
                                          controller: dateController,
                                          enabled: false,
                                          validator: (v) {
                                            if (v.toString().isEmpty) {
                                              return '?';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      'الاسم',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.transparent))),
                                        controller: nameController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                color: MaterialStateProperty.all<Color>(
                                    theme.mainColor.withOpacity(0.3)),
                                cells: [
                                  const DataCell(
                                    Text(
                                      'بداية الاختبار',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: InkWell(
                                        onTap: () => _selectTime(context,
                                            selectedTime, timeController),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent))),
                                          controller: timeController,
                                          enabled: false,
                                          validator: (v) {
                                            if (v.toString().isEmpty) {
                                              return '?';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      'نهاية الاختبار',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: InkWell(
                                        onTap: () => _selectTime(context,
                                            toSelectedTime, toTimeController),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent))),
                                          controller: toTimeController,
                                          enabled: false,
                                          validator: (v) {
                                            if (v.toString().isEmpty) {
                                              return '?';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
        floatingActionButton: Container(
          margin: const EdgeInsets.only(right: 30),
          child: MainButton(
            text: 'حفظ البيانات',
            pressed: () {
              if (formKey.currentState!.validate()) {
                adminController.addExam(
                  date: dateController.text,
                  examType: examType,
                  name: nameController.text,
                  semesterId: examController.currentSemester.value.id,
                  subjectId: subject.id,
                  time: timeController.text + '-' + toTimeController.text,
                );
              }
              clearText();
            },
          ),
        ),
      ),
    );
  }
}
