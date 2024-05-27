// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starsmeetupcelebrity/GlobalWidgets/text_field_dark_widget.dart';

import '../../Apis/user_apis.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../LocalStorage/shared_preferences.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_routes.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/validator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var editAboutMeController = TextEditingController();

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: MyPreferences.instance.user!.backgroundPicture !=
                          null
                      ? BoxDecoration(
                          color: purpleColor,
                          image: DecorationImage(
                            image: NetworkImage(
                              MyPreferences.instance.user!.backgroundPicture!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        )
                      : const BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      MyPreferences.instance.user!.backgroundPicture == null
                          ? const Column(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () async {
                            await showBackgroundPicEditDialog(context);
                            setState(() {});
                          },
                          child: Text(
                            "Edit",
                            style: eighteen600TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: MyPreferences.instance.user!.profilePicture != null
                      ? GestureDetector(
                          onTap: () async {
                            await showProfilePicEditDialog(context);
                            setState(() {});
                          },
                          child: Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  MyPreferences.instance.user!.profilePicture!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await showProfilePicEditDialog(context);
                            setState(() {});
                          },
                          child: Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 100,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  MyPreferences.instance.user!.name ?? "Loading..",
                  style: twentyTwo700TextStyle(
                    color: purpleColor,
                  ),
                ),
                Text(
                  MyPreferences.instance.user!.category ?? "Loading..",
                  style: eighteen600TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About Me",
                      style: twentyTwo700TextStyle(
                        color: purpleColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDescriptionEditDialog(context);
                        setState(() {});
                      },
                      child: Text(
                        "Edit",
                        style: eighteen600TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            thickness: 1.5,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  MyPreferences.instance.user!.bio ??
                      "No Description Added Yet!",
                  style: eighteen500TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            thickness: 1.5,
          ),
          const SizedBox(
            height: 30,
          ),
          BigButton(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 55,
            color: purpleColor,
            text: "Time Availability",
            onTap: () {
              Navigator.pushNamed(context, timeAvailabilityScreenRoute);
            },
            textStyle: twentyTwo700TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> showProfilePicEditDialog(pageContext) async {
    showGeneralDialog(
      context: pageContext,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (context, pageState) {
            return Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(pageContext).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Edit Profile Picture",
                            style: twenty600TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    EasyLoading.show(
                                        status: "Loading...\nPlease Wait");
                                    final imagePicker = ImagePicker();
                                    final XFile? image = await imagePicker
                                        .pickImage(source: ImageSource.camera);
                                    if (image != null) {
                                      Navigator.pop(context);
                                      await UserService()
                                          .uploadProfilePicture(
                                              MyPreferences
                                                  .instance.user!.userID
                                                  .toString()
                                                  .trim()
                                                  .toLowerCase(),
                                              image)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    }
                                    EasyLoading.dismiss();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: purpleColor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Camera",
                                  style: fourteen600TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    EasyLoading.show(
                                        status: "Loading...\nPlease Wait");
                                    final imagePicker = ImagePicker();
                                    final XFile? image = await imagePicker
                                        .pickImage(source: ImageSource.gallery);

                                    if (image != null) {
                                      Navigator.pop(context);
                                      await UserService()
                                          .uploadProfilePicture(
                                              MyPreferences
                                                  .instance.user!.userID
                                                  .toString()
                                                  .trim()
                                                  .toLowerCase(),
                                              image)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    }
                                    EasyLoading.dismiss();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: purpleColor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.photo,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Gallery",
                                  style: fourteen600TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showBackgroundPicEditDialog(pageContext) async {
    showGeneralDialog(
      context: pageContext,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, pageState) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(pageContext).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Edit Background Picture",
                          style: twenty600TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  EasyLoading.show(
                                      status: "Loading...\nPlease Wait");
                                  final imagePicker = ImagePicker();
                                  final XFile? image = await imagePicker
                                      .pickImage(source: ImageSource.camera);

                                  if (image != null) {
                                    Navigator.pop(context);
                                    await UserService()
                                        .uploadBackgroundPicture(
                                            MyPreferences.instance.user!.userID
                                                .toString()
                                                .trim()
                                                .toLowerCase(),
                                            image)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }
                                  EasyLoading.dismiss();
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: purpleColor.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Camera",
                                style: fourteen600TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  EasyLoading.show(
                                      status: "Loading...\nPlease Wait");
                                  final imagePicker = ImagePicker();
                                  final XFile? image = await imagePicker
                                      .pickImage(source: ImageSource.gallery);

                                  if (image != null) {
                                    await UserService()
                                        .uploadBackgroundPicture(
                                            MyPreferences.instance.user!.userID
                                                .toString()
                                                .trim()
                                                .toLowerCase(),
                                            image)
                                        .then((value) {
                                      Navigator.pop(context);
                                      setState(() {});
                                    });
                                  }
                                  EasyLoading.dismiss();
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: purpleColor.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.photo,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Gallery",
                                style: fourteen600TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  final formKey = GlobalKey<FormState>();
  Future<void> showDescriptionEditDialog(pageContext) async {
    showGeneralDialog(
      context: pageContext,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, pageState) {
          return Form(
            key: formKey,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(pageContext).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 270,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Edit About Me",
                            style: twenty600TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldDarkWidget(
                          hintText: "About Me",
                          labelText: "About Me",
                          validator: Validator.validateTextField,
                          textFieldController: editAboutMeController,
                        ),
                        const Spacer(),
                        BigButton(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          color: purpleColor,
                          text: "Save",
                          onTap: () async {
                            if (!formKey.currentState!.validate()) return;
                            formKey.currentState!.save();
                            EasyLoading.show(status: "Loading...\nPlease Wait");
                            if (editAboutMeController.text != "") {
                              await UserService()
                                  .updateAboutMe(
                                      MyPreferences.instance.user!.userID
                                          .toString(),
                                      editAboutMeController.text)
                                  .then((value) {
                                Navigator.pop(context);
                                setState(() {});
                              });
                            }
                            EasyLoading.dismiss();
                          },
                          textStyle: eighteen700TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
