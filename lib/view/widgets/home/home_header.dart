import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/children_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/screens/home/profile_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ChildrenController>(
      builder: (controller) => Row(
        children: [
          InkWell(
            onTap: (() => Get.to(() => ProfileScreen())),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage:
                  NetworkImage(controller.currentStudent.value.image),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            controller.currentStudent.value.name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          Badge(
            alignment: Alignment.topRight,
            position: BadgePosition.topEnd(top: 0, end: 25),
            animationDuration: const Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeContent: Text(
              '0',
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                //  Get.toNamed(Routes.cartScreen);
              },
              icon: Icon(
                Icons.notifications,
                color: theme.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
