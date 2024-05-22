// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class JoinMeetingButton extends StatefulWidget {
  final double width;
  final double height;
  Color color;
  final String text;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final double? borderRadius;
  final Widget widgetIcon;
  JoinMeetingButton(
      {Key? key,
      required this.width,
      this.borderRadius,
      required this.height,
      required this.color,
      required this.text,
      required this.onTap,
      required this.textStyle,
      required this.widgetIcon})
      : super(key: key);

  @override
  State<JoinMeetingButton> createState() => _JoinMeetingButtonState();
}

class _JoinMeetingButtonState extends State<JoinMeetingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.widgetIcon,
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.text,
              style: widget.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
