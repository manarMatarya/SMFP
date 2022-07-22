import 'package:flutter/material.dart';
import 'package:smfp/view/widgets/skelton.dart';

class MarksCardSkelton extends StatelessWidget {
  const MarksCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Skeleton(width: 300),
              SizedBox(height: 16 / 2),
              Skeleton(width: 300),
              SizedBox(height: 16 / 2),
            ],
          ),
        ),
        const Skeleton(height: 50, width: 50),
        const SizedBox(width: 10),
      ],
    );
  }
}