import 'package:flutter/material.dart';

import '../Utilities/app_text_styles.dart';

class MeetingDetailsRowWidget extends StatelessWidget {
  final String title;
  final String description;
  const MeetingDetailsRowWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: sixteen600TextStyle(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Text(
            description,
            style: sixteen600TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
