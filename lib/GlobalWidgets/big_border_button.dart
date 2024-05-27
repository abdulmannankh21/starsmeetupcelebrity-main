// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BigBorderButton extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final double? borderRadius;
  const BigBorderButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap,
      required this.textStyle,
      required this.color,
      this.borderRadius})
      : super(key: key);

  @override
  State<BigBorderButton> createState() => _BigBorderButtonState();
}

class _BigBorderButtonState extends State<BigBorderButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.color,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
