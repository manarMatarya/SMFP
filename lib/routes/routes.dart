import 'package:get/get.dart';
import 'package:smfp/admin/view/screens/admin_main_screen.dart';
import 'package:smfp/logic/middlewares/auth_middleware.dart';
import 'package:smfp/teacher/view/screens/teacher_home_screen.dart';

import 'package:smfp/view/screens/auth/otp_screen.dart';
import 'package:smfp/view/screens/main/main_screen.dart';
import 'package:smfp/view/screens/main/children_screen.dart';
import 'package:smfp/view/screens/more/complaint_screen.dart';
import 'package:smfp/view/screens/more/report_screen.dart';
import 'package:smfp/view/screens/more/transfer_screen.dart';
import 'package:smfp/view/screens/more/who_screen.dart';

import '../view/screens/auth/login_screen.dart';

class AppRoutes {
  //initialRoutes
  static const login = Routes.loginScreen;
  static const otp = Routes.otp;
  static const notify = Routes.notify;
  static const main = Routes.mainScreen;
  static const children = Routes.childrenScreen;

  //getPages
  static final routes = [
    GetPage(
      middlewares: [AuthMiddleWare()],
      name: Routes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: Routes.teacherScreen,
      page: () => TeacherHomeScreen(),
    ),
    GetPage(
      name: Routes.adminScreen,
      page: () => const AdminMainScreen(),
    ),
    GetPage(
      name: Routes.childrenScreen,
      page: () => ChildrenScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => const OtpScreen(
        phone: '',
      ),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: Routes.complaintScreen,
      page: () => ComplaintScreen(),
    ),
    GetPage(
      name: Routes.reportScreen,
      page: () => ReportScreen(),
    ),
    GetPage(
      name: Routes.transferStudentScreen,
      page: () => TransferStudentScreen(),
    ),
    GetPage(
      name: Routes.whoScreen,
      page: () => const WhoScreen(),
    ),
  ];
}

class Routes {
  static const loginScreen = '/loginScreen';
  static const otp = '/otp';
  static const notify = '/notify';
  static const otpScreen = '/otpScreen';
  static const childrenScreen = '/childrenScreen';
  static const teacherScreen = '/teacherScreen';
  static const adminScreen = '/adminScreen';
  static const mainScreen = '/mainScreen';
  static const complaintScreen = '/complaintScreen';
  static const reportScreen = '/reportScreen';
  static const transferStudentScreen = '/transferStudentScreen';
  static const whoScreen = '/whoScreen';
}
