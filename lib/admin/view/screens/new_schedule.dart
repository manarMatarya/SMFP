import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/admin/view/widget/schedule/class.dart';
import 'package:smfp/admin/view/widget/schedule/items.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/my_appbar.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class AddScheduale extends StatefulWidget {
  const AddScheduale({Key? key}) : super(key: key);

  @override
  State<AddScheduale> createState() => _AddSchedualeState();
}

var currentDay = 0;
List subjects = [];

class _AddSchedualeState extends State<AddScheduale> {
  AdminController controller = Get.put(AdminController(), permanent: true);
  final formKey = GlobalKey<FormState>();

  List days = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];

  List numbers = [
    'الأولى',
    'الثانية',
    'الثالثة',
    'الرابعة',
    'الخامسة',
    'السادسة'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(),
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
                          text: "اضافة جدول الحصص",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CurrentClass(),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    subjects = [];
                                    currentDay = index;
                                  });
                                },
                                child: dayCard(
                                  day: days[index],
                                  index: index,
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: DataTable(
                            //  columnSpacing: 40,
                              headingRowColor: MaterialStateProperty.all(
                                  theme.mainColor.withOpacity(0.3)),
                              headingTextStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: theme.secondaryColor),
                              dataTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: theme.mainColor),
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'الحصة',
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: 210,
                                    child: Center(
                                      child: Text(
                                        'المادة',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: [
                                for (int i = 0; i < numbers.length; i++)
                                  buildRowItems(
                                    day: numbers[i],
                                  )
                              ]),
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
        floatingActionButton: customButton(
            controller: controller,
            currentDay: currentDay,
            days: days,
            formKey: formKey,
            subjects: subjects),
      ),
    );
  }

  Widget dayCard({day, index}) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: currentDay == index ? theme.mainColor : Colors.white,
      ),
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: currentDay == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  DataRow buildRowItems({
    required String day,
  }) {
    //  var subject;
    return DataRow(cells: [
      DataCell(
        Text(
          day,
          style: const TextStyle(
            color: theme.secondaryColor,
            fontSize: 16,
          ),
        ),
      ),
      DataCell(
        GetX<AdminController>(builder: (controller) {
          return DropdownButtonFormField(
            validator: (v) {
              if (v.toString().isEmpty) {
                return '?';
              } else {
                return null;
              }
            },
            onChanged: (val) {
              setState(() {
                subjects.add(val);
              });
            },
            items: controller.subjects.map((sub) {
              return DropdownMenuItem(
                value: sub,
                child: Text(
                  sub.name,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          );
        }),
      ),
    ]);
  }
}
