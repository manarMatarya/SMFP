import 'package:flutter/material.dart';
import 'package:smfp/view/widgets/skelton.dart';

class HomeworkCardSkelton extends StatelessWidget {
  const HomeworkCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Skeleton(
      width: double.infinity,
      height: 100,
    );
  }
}