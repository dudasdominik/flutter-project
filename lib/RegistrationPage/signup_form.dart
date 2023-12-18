import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petpals_frontend/RegistrationPage/date_form_field.dart';
import 'package:petpals_frontend/RegistrationPage/email_form_field.dart';
import 'package:petpals_frontend/RegistrationPage/gender_form_field.dart';
import 'package:petpals_frontend/RegistrationPage/password_form_field.dart';
import 'package:petpals_frontend/RegistrationPage/user_signup_view_model.dart';

import 'package:http/http.dart' as http;

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final ValueChanged<UserSignupViewModel> onChanged;
  final UserSignupViewModel viewModel;
  SignupForm(
      {super.key,
      required this.formkey,
      required this.onChanged,
      required this.viewModel});
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmationFocus = FocusNode();
  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmationFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          EmailFormField(
            focusNode: emailFocus,
            nextFocusNode: passwordFocus,
            onChanged: (s) =>
                widget.onChanged(widget.viewModel.copyWith(email: s)),
            currentValue: widget.viewModel.email,
            validator: widget.viewModel.emailValidator,
          ),
          PasswordFormField(
            focusNode: passwordFocus,
            nextFocusNode: confirmationFocus,
            onChanged: (s) =>
                widget.onChanged(widget.viewModel.copyWith(password: s)),
            currentValue: widget.viewModel.password,
            labelText: "Password",
            validator: widget.viewModel.passwordValidator,
          ),
          PasswordFormField(
            focusNode: confirmationFocus,
            nextFocusNode: null,
            currentValue: widget.viewModel.passwordConfirmation,
            onChanged: (s) => widget
                .onChanged(widget.viewModel.copyWith(passwordConfirmation: s)),
            labelText: "Confrim Password",
            validator: widget.viewModel.passwordConfirmationValidator,
          ),
          DateFormField(
            currentValue: widget.viewModel.birthDate,
            validator: widget.viewModel.birthDateValidator,
            label: "Birth date",
            onChanged: (date) =>
                widget.onChanged(widget.viewModel.copyWith(birthDate: date)),
          ),
          GenderForm(
            label: "Gender",
            currentValue: widget.viewModel.gender,
            validator: widget.viewModel.genderValidator,
            onChanged: (gender) =>
                widget.onChanged(widget.viewModel.copyWith(gender: gender)),
          ),
        ]
            .map((e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
