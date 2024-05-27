import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Apis/policy_apis.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../models/faq_model.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  List<PoliciesModel>? privacyPolicyText;

  @override
  void initState() {
    getPrivacyPolicy();
    super.initState();
  }

  getPrivacyPolicy() async {
    privacyPolicyText = await PrivacyPolicyService().getPrivacyPolicy();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: privacyPolicyText == null
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
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
                    "Privacy Policy",
                    style: twentyTwo700TextStyle(color: purpleColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              privacyPolicyText == null
                  ? const CupertinoActivityIndicator()
                  : privacyPolicyText!.isEmpty
                      ? const Center(
                          child: Text("No Terms And Conditions Available"),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < privacyPolicyText!.length; i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    privacyPolicyText![i].title,
                                    textAlign: TextAlign.justify,
                                    style: eighteen700TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    privacyPolicyText![i].description,
                                    textAlign: TextAlign.justify,
                                    style: seventeen500TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
