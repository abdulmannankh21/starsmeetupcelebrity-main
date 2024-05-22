import 'package:flutter/material.dart';

import '../Utilities/app_text_styles.dart';

class SettingsWidget extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onTap;
  final Color? imageColor;
  const SettingsWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 30,
              height: 30,
              color: imageColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: twenty600TextStyle(color: Colors.black),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
