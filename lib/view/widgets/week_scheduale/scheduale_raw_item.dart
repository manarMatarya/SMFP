import 'package:flutter/material.dart';
import 'package:smfp/utiles/theme.dart';

DataRow buildRowItems({
  required String day,
  required String one,
  required String two,
  required String three,
  required String four,
  required String five,
  required String six,
}) {
  return DataRow(cells: [
    DataCell(Text(
      day,
      style: const TextStyle(color: theme.secondaryColor),
    )),
    DataCell(Text(one)),
    DataCell(Text(two)),
    DataCell(Text(three)),
    DataCell(Text(four)),
    DataCell(Text(five)),
    DataCell(Text(six)),
  ]);
}