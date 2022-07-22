import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddAttendance extends StatefulWidget {
  AddAttendance({Key? key}) : super(key: key);

  @override
  State<AddAttendance> createState() => _AddAttendanceState();
}

List subjects = [];
List status = [];

class _AddAttendanceState extends State<AddAttendance> {
  AdminController controller = Get.put(AdminController(), permanent: true);
  var dateController = TextEditingController();

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
  var currentClass;

  List<TextEditingController> _reasonControllers = [];

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
                       
                          text: "حضور وغياب الطلاب",
                         
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
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: theme.secondaryYellow,
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
                              'التاريخ : ',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => _selectDate(context),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'يجب ادخال تاريخ اليوم';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: theme.secondaryYellow),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: theme.secondaryYellow,
                                    filled: true,
                                  ),
                                  enabled: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GetX<AdminController>(
                          builder: (controller) => Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.students.length,
                              itemBuilder: (BuildContext context, int index) {
                                _reasonControllers.add(TextEditingController());
                                status.add('');
                                return _buildList(controller.students[index],
                                    _reasonControllers[index], index);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  color: theme.secondaryColor,
                                  thickness: 1,
                                );
                              },
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
            ? SizedBox()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MainButton(
                  pressed: () {
                    for (int i = 0; i < _reasonControllers.length; i++) {
                      if (status[i] == 'معذور' || status[i] == 'بدون عذر') {
                        controller.addAttendance(
                          reason: _reasonControllers[i].text,
                          studentId: controller.students[i].id,
                          date: dateController.text,
                          status: status[i],
                        );
                      }
                    }
                  },
                  text: 'حفظ البيانات',
                ),
              ),
      ),
    );
  }

  Widget _buildList(list, reasonController, index) {
    List statuses = ['بدون عذر', 'معذور', 'حاضر'];
    return ExpansionTile(
      trailing: SizedBox(
        width: 100,
        child: DropdownButtonFormField(
          hint: const Text(
            'حاضر',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: theme.mainColor),
          ),
          decoration: const InputDecoration.collapsed(hintText: ''),
          onChanged: (val) {
            setState(() {
              status[index] = val;
            });
          },
          items: statuses.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(
                status,
                style: status == 'بدون عذر'
                    ? const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: theme.mainColor, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
      ),
      title: Text(
        list.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: TextFormField(
              controller: reasonController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
                  hintText: 'سبب غياب الطالب'),
            )),
      ],
    );
  }
}
