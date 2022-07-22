import 'package:flutter/material.dart';
import 'package:smfp/utiles/theme.dart';

class ScrollText extends StatelessWidget {
  final String text;


  const ScrollText({
    required this.text,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: theme.mainColor.withOpacity(0.3),
      height: 550,
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 3,
              wordSpacing: 3,
            ),
          ),
        ),
      ),
    );
  }
}
