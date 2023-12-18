import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final String? currentValue;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  const EmailFormField(
      {super.key,
      required this.onChanged,
      this.validator,
      this.currentValue,
      this.nextFocusNode,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      initialValue: currentValue,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: "example@gmail.com",
        labelText: "Email",
        helperText: "",
      ),
      validator: validator,
    );
  }
}
