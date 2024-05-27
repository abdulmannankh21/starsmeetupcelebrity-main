// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Apis/auth_controller.dart';
import '../../Apis/user_apis.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/text_field_widget.dart';
import '../../LocalStorage/shared_preferences.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_routes.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/validator.dart';
import '../../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  FirebaseMessaging? _firebaseMessaging;

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
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    scale: 3,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Login",
                    style: thirty800TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldLoginWidget(
                    hintText: "Enter your Email",
                    labelText: "Email",
                    obscureText: false,
                    textFieldController: emailController,
                    validator: Validator.emailValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldLoginWidget(
                    hintText: "Enter your Password",
                    textFieldController: passwordController,
                    validator: Validator.passwordValidator,
                    obscureText: obscureText,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        child: Icon(
                          obscureText == true
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: Colors.white,
                          size: 25,
                        )),
                    labelText: "Password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              rememberMe = !rememberMe;
                              setState(() {});
                            },
                            child: Container(
                              width: 23,
                              height: 23,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: rememberMe
                                      ? Colors.transparent
                                      : Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                color: !rememberMe
                                    ? Colors.transparent
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: 20,
                                  color: !rememberMe
                                      ? Colors.transparent
                                      : purpleColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Remember Me",
                            style: sixteen700TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, forgotPasswordScreenRoute);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: sixteen600TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BigButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 55,
                    color: Colors.white,
                    text: "Login",
                    onTap: () {
                      onTapSignIn();
                    },
                    textStyle: twentyTwo700TextStyle(color: purpleColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapSignIn() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    if (kDebugMode) {
      print(emailController.text.trim().toLowerCase());
    }
    EasyLoading.show(status: "Loading...");
    Authentication()
        .signIn(
            email: emailController.text.trim().toLowerCase(),
            password: passwordController.text.toString())
        .then((result) async {
      if (result == null) {
        EasyLoading.dismiss();

        UserModel? user = await UserService()
            .getUser(emailController.text.trim().toLowerCase());
        if (user != null) {
          MyPreferences.instance.setUser(user: user);

          // Retrieve FCM token
          // String? fcmToken = await _firebaseMessaging?.getToken();

          // Store FCM token in user document

          EasyLoading.showSuccess("Log In Successful");
          Navigator.pushNamedAndRemoveUntil(
              context, homeScreenRoute, (route) => true,
              arguments: true);
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: redColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        if (kDebugMode) {
          print('User does not exist.');
        }
        EasyLoading.dismiss();
      }
    });
  }
}
