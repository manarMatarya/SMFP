import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/logic/controller/auth_controller.dart';

import 'package:smfp/routes/routes.dart';

class AuthMiddleWare extends GetMiddleware {

  @override
  RouteSettings? redirect(route) {
    if (GetStorage().read('role') == 'admin') {
      return const RouteSettings(name: Routes.adminScreen);
    } else if (GetStorage().read('role') == 'teacher') {
      return const RouteSettings(name: Routes.teacherScreen);
    } else if (FirebaseAuth.instance.currentUser != null ||
        GetStorage().read('role') == 'parent') {
      return const RouteSettings(name: Routes.childrenScreen);
    }
  }
}
