import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;
  final String labelText;
  final String? currentValue;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  const PasswordFormField(
      {super.key,
      this.onChanged,
      required this.validator,
      required this.labelText,
      this.currentValue,
      this.nextFocusNode,
      this.focusNode});

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextFocusNode?.requestFocus(),
      obscureText: _obscurePassword,
      initialValue: widget.currentValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          labelText: widget.labelText,
          helperText: "",
          suffixIcon: IconButton(
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.blue,
              ))),
    );
  }
}
