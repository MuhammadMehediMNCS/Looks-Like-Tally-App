import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String? labelText;
  final bool readOnly;
  final int? maxLine;
  final VoidCallback? onPressed;

  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.keyboard,
    this.labelText,
    this.readOnly = false,
    this.maxLine,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 12.0),
      TextFormField(
        keyboardType: keyboard,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.blue)),
        ),
        readOnly: readOnly,
        maxLines: maxLine,
        onTap: onPressed,
      ),
    ],
  );
}
