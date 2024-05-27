import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Apis/user_apis.dart';
import '../../LocalStorage/shared_preferences.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';

class SupportYourStarSettingsScreen extends StatefulWidget {
  const SupportYourStarSettingsScreen({super.key});

  @override
  State<SupportYourStarSettingsScreen> createState() =>
      _SupportYourStarSettingsScreenState();
}

class _SupportYourStarSettingsScreenState
    extends State<SupportYourStarSettingsScreen> {
  bool value = true;

  @override
  void initState() {
    value = MyPreferences.instance.user!.supportYourStar ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              "Support Your Star",
              style: twentyTwo600TextStyle(color: purpleColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Disable",
                    style: eighteen500TextStyle(),
                  ),
                  CupertinoSwitch(
                    activeColor: purpleColor,
                    trackColor: Colors.grey,
                    value: value,
                    onChanged: (val) {
                      value = val;
                      UserService()
                          .updateSupportYourStar(
                              MyPreferences.instance.user!.userID!
                                  .toLowerCase()
                                  .toString(),
                              value)
                          .then(
                        (value) {
                          setState(() {});
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
