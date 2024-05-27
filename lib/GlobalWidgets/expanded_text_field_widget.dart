import 'package:flutter/material.dart';

import '../Utilities/app_text_styles.dart';

class ExpandedTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String lablelText;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  const ExpandedTextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.lablelText,
      this.textFieldController,
      this.validator})
      : super(key: key);

  @override
  State<ExpandedTextFieldWidget> createState() =>
      _ExpandedTextFieldWidgetState();
}

class _ExpandedTextFieldWidgetState extends State<ExpandedTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.lablelText,
            style: eighteen400TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: widget.validator,
          maxLines: 7,
          controller: widget.textFieldController,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey[700]!,
              fontSize: 17,
            ),
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
