import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smfp/admin/logic/controller/admin_controller.dart';
import 'package:smfp/admin/view/screens/admin_main_screen.dart';
import 'package:smfp/admin/view/screens/admin_screen.dart';

import 'package:smfp/routes/routes.dart';
import 'package:smfp/teacher/view/screens/teacher_home_screen.dart';

import 'package:smfp/utiles/theme.dart';

import 'package:smfp/view/screens/auth/otp_screen.dart';
import 'package:smfp/view/screens/main/children_screen.dart';

class AuthController extends GetxController {
  String id = '';
  String verificationID = "";
  bool isParent = false;
  bool isTeacher = false;
  bool isAdmin = false;
  bool isSignedIn = false;
  String deviceToken = "";

  final GetStorage authBox = GetStorage();
  final CollectionReference parentRef =
      FirebaseFirestore.instance.collection('Parent');
  final CollectionReference teacherRef =
      FirebaseFirestore.instance.collection('Teacher');
  final CollectionReference adminRef =
      FirebaseFirestore.instance.collection('School');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? signedInUser;

  phoneLogin({required String phone}) async {
    isParent = await checkIfParent(phone);
    isTeacher = await checkIfTeacher(phone);
    isAdmin = await checkIfAdmin(phone);

    if (isParent || isTeacher || isAdmin) {
      try {
        _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 10),
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              Get.snackbar(
                'خطأ',
                'رقم الموبايل غير صحيح',
                backgroundColor: theme.mainColor,
                colorText: Colors.white,
              );
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationID = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        Get.off(OtpScreen(
          phone: phone,
        ));
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
        Get.snackbar(
          'خطأ',
          'خطأ في رقم الموبايل',
          backgroundColor: theme.mainColor,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'خطأ',
        'رقم الموبايل غير متوفر',
        backgroundColor: theme.mainColor,
        colorText: Colors.white,
      );
    }
  }

  void verifyOTP({required String otp}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: otp,
    );
    try {
      await _auth.signInWithCredential(credential).then((value) async {
        signedInUser = value.user;
        isSignedIn = true;
        authBox.write("auth", isSignedIn);
        authBox.write("id", id);

        if (isAdmin) {
          authBox.write('role', 'admin');
          Get.off(const AdminMainScreen());
        } else if (isTeacher) {
          authBox.write('role', 'teacher');
          Get.off(TeacherHomeScreen());
        } else if (isParent) {
          authBox.write('role', 'parent');
          Get.off(ChildrenScreen());
        }
        print("ffffff ${GetStorage().read('token')}");

        FirebaseFirestore.instance.collection('token').doc(id).set({
          'token': GetStorage().read('token'),
          'role': authBox.read('role'),
          'id': id
        });

        Fluttertoast.showToast(
          msg: "تم تسجيل الدخول ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: theme.mainColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }).catchError((error) {
        String message = 'الكود المدخل غير صحيح';
        Get.snackbar(
          'خطأ',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: theme.mainColor,
          colorText: Colors.white,
        );
      });
    } catch (e) {
      Get.snackbar(
        'خطأ',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: theme.mainColor,
        colorText: Colors.white,
      );
    }
  }

  signOutFromApp() async {
    await _auth.signOut().then((value) {
      authBox.erase();
      Get.offNamed(AppRoutes.login);
    }).catchError((e) {
      Get.snackbar(
        'Error!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  Future<bool> checkIfParent(phone) async {
    await parentRef.where('phone', isEqualTo: phone).get().then((value) {
      id = value.docs[0]['id'];
      isParent = true;
    }).catchError((e) {
      isParent = false;
    });
    return isParent;
  }

  Future<bool> checkIfTeacher(phone) async {
    await teacherRef.where('phone', isEqualTo: phone).get().then((value) {
      id = value.docs[0]['id'];
      isTeacher = true;
    }).catchError((e) {
      isTeacher = false;
    });
    return isTeacher;
  }

  Future<bool> checkIfAdmin(phone) async {
    await adminRef.where('phone', isEqualTo: phone).get().then((value) {
      id = value.docs[0]['id'];
      isAdmin = true;
    }).catchError((e) {
      isAdmin = false;
    });
    return isAdmin;
  }
}
