import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar myAppBar() {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
    toolbarHeight: 100,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Image.asset(
      'assets/images/logo.png',
    ),
    // actions: [
    //   IconButton(
    //     onPressed: () => Get.back(),
    //     icon: const Icon(
    //       Icons.navigate_next_sharp,
    //       color: Colors.black,
    //       size: 40,
    //     ),
    //   )
    // ],
  );
}
