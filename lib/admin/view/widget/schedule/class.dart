import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';

class CurrentClass extends StatefulWidget {
  const CurrentClass({Key? key}) : super(key: key);

  @override
  State<CurrentClass> createState() => _CurrentClassState();
}

class _CurrentClassState extends State<CurrentClass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'الشعبة : ',
          style: GoogleFonts.lato(
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 280,
          child: GetX<AdminController>(builder: (controller) {
            return DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return 'يجب تحديد الشعبة';
                } else {
                  return null;
                }
              },
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
              ),
              items: controller.classes.map((clas) {
                return DropdownMenuItem(
                  value: clas,
                  child: Text(
                    clas.name,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  controller.currentClass = value;
                });
              },
            );
          }),
        ),
      ],
    );
  }
}
