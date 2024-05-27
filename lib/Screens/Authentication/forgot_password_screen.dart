import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:starsmeetupcelebrity/Utilities/app_routes.dart';

import '../../Apis/auth_controller.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/text_field_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: purpleGradient,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        "Forgot Password",
                        style: twentyTwo700TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                    TextFieldWidget(
                      obscureText: false,
                    hintText: "example@gmail.com",
                    labelText: "Enter Email Address",
                    textFieldController: emailController,
                    validator: Validator.validateTextField,

                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BigButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 55,
                    color: Colors.white,
                    text: "Send",
                    onTap: () async {
                      if (!formKey.currentState!.validate()) return;
                      formKey.currentState!.save();
                      EasyLoading.show(status: "Loading...");
                      await Authentication()
                          .enterEmailAuth(emailController.text)
                          .then((value) {
                        resetPasswordEmailPopUp();
                        EasyLoading.dismiss();
                      });
                      EasyLoading.dismiss();
                    },

                    textStyle: twentyTwo700TextStyle(color: purpleColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetPasswordEmailPopUp() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: greenColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Reset email has been sent successfully! Please check your email to reset your password",
                        style: eighteen600TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: BigButton(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        color: purpleColor,
                        text: "Login",
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, loginScreenRoute, (route) => false);
                        },
                        borderRadius: 5.0,
                        textStyle: eighteen700TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
