import 'package:flutter/material.dart';

import '../Utilities/app_text_styles.dart';

class SideDrawerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String image;
  const SideDrawerWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Image.asset(
                image,
                width: 25,
                height: 25,
                color: Colors.white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: eighteen700TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
