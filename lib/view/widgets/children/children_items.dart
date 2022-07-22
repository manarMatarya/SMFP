import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/main/add_student.dart';
import 'package:smfp/view/widgets/skelton.dart';

Widget showToolTip() {
  return Tooltip(
    message: 'تسجيل طالب جديد',
    waitDuration: const Duration(seconds: 1),
    showDuration: const Duration(seconds: 3),
    padding: const EdgeInsets.all(12),
    height: 35,
    verticalOffset: 100,
    preferBelow: true,
    textStyle: const TextStyle(
        fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            offset: Offset(6.0, 6.0),
          ), //BoxShadow
        ],
        color: Colors.black26), //BoxDecoration
    child: GestureDetector(
      onTap: () {
        Get.to(() => AddStudent());
      },
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/addUser.png')),
          borderRadius: BorderRadius.circular(0.50),
        ),
        width: 50.0,
        height: 50.0,
      ),
    ), //Text
  );
}

Widget buildChildItems({
  required String image,
  required String name,
}) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          children: [
            SizedBox(
              child: Card(
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
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: theme.mainColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 80, width: 80),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Skeleton(width: 200),
              SizedBox(height: 16 / 2),
            ],
          ),
        )
      ],
    );
  }
}
