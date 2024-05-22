import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Apis/terms_and_conditions_apis.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../models/faq_model.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  List<PoliciesModel>? termsAndConditionsText;
  @override
  void initState() {
    getTermsAndConditions();
    super.initState();
  }

  getTermsAndConditions() async {
    termsAndConditionsText =
        await TermsAndConditionsService().getTermsAndConditions();

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
            crossAxisAlignment: termsAndConditionsText == null
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
                    "Terms of use",
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
              termsAndConditionsText == null
                  ? const CupertinoActivityIndicator()
                  : termsAndConditionsText!.isEmpty
                      ? const Center(
                          child: Text("No Terms And Conditions Available"),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < termsAndConditionsText!.length;
                                i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    termsAndConditionsText![i].title,
                                    textAlign: TextAlign.justify,
                                    style: eighteen700TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    termsAndConditionsText![i].description,
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
                        )
            ],
          ),
        ),
      ),
    );
  }
}
