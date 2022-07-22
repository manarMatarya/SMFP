import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smfp/logic/controller/auth_controller.dart';
import 'package:smfp/utiles/theme.dart';
import 'package:smfp/view/widgets/auth/auth_text_form_field.dart';
import 'package:smfp/view/widgets/custom_button.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final fromKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 100),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextUtils(
                          text: "تسجيل الدخول",
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset('assets/images/login.png')),
                        const SizedBox(
                          height: 30,
                        ),
                        // const TextUtils(
                        //   fontSize: 18,
                        //   fontWeight: FontWeight.bold,
                        //   text: "أدخل رقم الموبايل الخاص بك",
                        //   color: theme.secondaryColor,
                        //   underLine: TextDecoration.none,
                        //   textAlign: TextAlign.right,
                        // ),
                         TextUtils(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          text:
                              "  من فضلك أدخل رقم الموبايل الخاص بك و المكون من 10 أرقام للدخول الى النظام ",
                          color: theme.secondaryColor,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 20),
                        AuthTextFromField(
                          controller: phoneController,
                          obscureText: false,
                          validator: (value) {
                            if (value.toString().length < 10) {
                              return 'رقم الموبايل لا يمكن ان يكون اقل من 10 ارقام';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: theme.mainColor,
                          ),
                          suffixIcon: const Text(''),
                          hintText: 'رقم الموبايل',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MainButton(
                          text: 'تسجيل الدخول',
                          pressed: () async {
                            if (fromKey.currentState!.validate()) {
                              String phone =
                                  phoneController.text.toString().trim();

                              controller.phoneLogin(
                                phone: '+97' + phone,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
