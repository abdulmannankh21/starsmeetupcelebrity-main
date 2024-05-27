import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Apis/auth_controller.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/text_field_dark_widget.dart';
import '../../LocalStorage/shared_preferences.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool value = true;
  final formKey = GlobalKey<FormState>();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var newPasswordController2 = TextEditingController();
  bool obscureText2 = true;
  bool obscureText3 = true;
  bool obscureText1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
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
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  Text(
                    "Settings",
                    style: twentyTwo700TextStyle(color: purpleColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Change Password",
                style: twentyTwo600TextStyle(color: purpleColor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldDarkWidget(
                hintText: "Enter Old Password",
                labelText: "Old Password",
                textFieldController: oldPasswordController,
                validator: Validator.validateTextField,
                suffixIcon: GestureDetector(
                    onTap: () {
                      obscureText1 = !obscureText1;
                      setState(() {});
                    },
                    child: Icon(
                      obscureText1 == true
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldDarkWidget(
                hintText: "Enter New Password",
                suffixIcon: GestureDetector(
                    onTap: () {
                      obscureText2 = !obscureText2;
                      setState(() {});
                    },
                    child: Icon(
                      obscureText2 == true
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: Colors.black,
                      size: 20,
                    )),
                labelText: "New Password",
                textFieldController: newPasswordController,
                validator: Validator.passwordValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldDarkWidget(
                hintText: "Enter Confirm Password",
                suffixIcon: GestureDetector(
                    onTap: () {
                      obscureText3 = !obscureText3;
                      setState(() {});
                    },
                    child: Icon(
                      obscureText3 == true
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: Colors.black,
                      size: 20,
                    )),
                labelText: "Confirm Password",
                textFieldController: newPasswordController2,
                validator: (value) {
                  if (newPasswordController2.text.isEmpty) {
                    return 'Confirm Password field is required';
                  } else if (newPasswordController2.text !=
                      newPasswordController.text) {
                    return "It doesn't matches with password";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              BigButton(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                color: purpleColor,
                text: "Update",
                onTap: () async {
                  if (!formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  EasyLoading.show(status: "Loading...");
                  var response = await Authentication().changePassword(
                      MyPreferences.instance.user!.email!
                          .toLowerCase()
                          .toString(),
                      oldPasswordController.text,
                      newPasswordController.text);
                  if (response == null) {
                    if (mounted) {
                      changePasswordEmailPopUp();
                    }
                  }

                  EasyLoading.dismiss();
                },
                textStyle: twentyTwo700TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changePasswordEmailPopUp() {
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
                height: 240,
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
                        "Your password has been changed successfully!",
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
                        text: "Continue",
                        onTap: () async {
                          Navigator.pop(context);
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
