import 'package:flutter/material.dart';

import '../../Apis/help_apis.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/expanded_text_field_widget.dart';
import '../../GlobalWidgets/text_field_dark_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/validator.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  var emailController = TextEditingController();
  var subjectController = TextEditingController();
  var descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                    "Help",
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
              TextFieldDarkWidget(
                hintText: "Enter your Email",
                labelText: "Email",
                textFieldController: emailController,
                validator: Validator.emailValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldDarkWidget(
                hintText: "Enter your Subject",
                labelText: "Subject",
                textFieldController: subjectController,
                validator: Validator.validateTextField,
              ),
              const SizedBox(
                height: 20,
              ),
              ExpandedTextFieldWidget(
                hintText: "Enter your Message",
                lablelText: "Message",
                textFieldController: descriptionController,
                validator: Validator.validateTextField,
              ),
              const SizedBox(
                height: 30,
              ),
              BigButton(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                color: purpleColor,
                text: "Send",
                onTap: () async {
                  if (!formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  await HelpService()
                      .uploadHelpRequest(emailController.text,
                          subjectController.text, descriptionController.text)
                      .then((value) {
                    Navigator.pop(context);
                    setState(() {});
                  });
                },
                textStyle: twentyTwo700TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
