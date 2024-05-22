import 'package:flutter/material.dart';

import '../Utilities/app_text_styles.dart';

class TextFieldDarkWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;

  final void Function()? onTap;

  const TextFieldDarkWidget(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.textFieldController,
      this.readOnly = false,
      this.onTap,
      this.validator,
      this.suffixIcon,
      this.prefixIcon})
      : super(key: key);

  @override
  State<TextFieldDarkWidget> createState() => _TextFieldDarkWidgetState();
}

class _TextFieldDarkWidgetState extends State<TextFieldDarkWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: eighteen500TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.textFieldController,
          validator: widget.validator,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            hintStyle: TextStyle(
              color: Colors.grey[700]!,
              fontSize: 17,
            ),
            hintText: widget.hintText,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey[600]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey[600]!,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
