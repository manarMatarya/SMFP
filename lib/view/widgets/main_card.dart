import 'package:flutter/material.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/utiles/theme.dart';

Widget buildMainCard({
  required String image,
  required String name,
   Color color = Colors.white,
}) {
  return Card(
    color: color,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}



Widget buildTeacherCard({
  required String image,
  required String name,
   Color color = Colors.white,
}) {
  return Card(
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.asset(image)),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}