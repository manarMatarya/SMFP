import 'package:flutter/material.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/chat.dart';

Widget withExcuseItem({
  required String status,
  required String reason,
  required String date,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: CustomPaint(
      painter: ChatBubble(
        color: theme.mainColor,
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              "غائب - " + status,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              reason,
              style: const TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                date,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget withoutExcuseItem({
  required String status,
  required String reason,
  required String date,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: CustomPaint(
      painter: ChatBubble(
        color: const Color.fromRGBO(215, 204, 200, 1),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.dangerous_outlined,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "غائب - " + status,
                  style: const TextStyle(color: Colors.black),
                ),
              ]),
            ),
            Text(
              reason,
              style: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                date,
                style: const TextStyle(color: Colors.black, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
