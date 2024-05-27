// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BigButton extends StatefulWidget {
  final double width;
  final double height;
  Color color;
  final String text;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final double? borderRadius;
  BigButton(
      {Key? key,
      required this.width,
      this.borderRadius,
      required this.height,
      required this.color,
      required this.text,
      required this.onTap,
      required this.textStyle})
      : super(key: key);

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
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
