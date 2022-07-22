import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/routes/routes.dart';
import 'package:smfp/view/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.offNamed(AppRoutes.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset('assets/images/logo.png'),
    ));
  }
}
