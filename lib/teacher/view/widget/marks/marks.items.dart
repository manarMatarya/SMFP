import 'package:flutter/material.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/skelton.dart';

Widget examType({color, text}) {
  return Card(
    color: color,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget listItem(text) {
  return ListTile(
    leading: Image.asset('assets/images/marks.png'),
    title: Text(
      text,
      style: const TextStyle(color: theme.secondaryColor, fontSize: 18),
    ),
  );
}

Widget examsCardSkelton() {
  return Row(
    children: [
      const Skeleton(height: 50, width: 50),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Skeleton(width: 200),
            SizedBox(height: 16 / 2),
          ],
        ),
      ),
    ],
  );
}

Widget studentItem({add, image, text}) {
  return ListTile(
    leading: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
      ),
    ),
    trailing: SizedBox(
      width: 60,
      child: TextFormField(
        validator: (v) {
          if (v.toString().isEmpty) {
            return '?';
          } else {
            return null;
          }
        },
        style: const TextStyle(color: theme.mainColor),
        controller: add,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: const TextStyle(color: theme.mainColor),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  );
}
