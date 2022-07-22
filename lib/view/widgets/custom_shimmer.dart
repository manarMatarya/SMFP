import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smfp/utiles/theme.dart';

Widget customShimmer({item}) {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 104, 103, 103),
    highlightColor: theme.mainColor,
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) => item,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    ),
  );
}
