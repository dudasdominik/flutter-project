import 'package:petpals_frontend/RegistrationPage/string_extensions.dart';

class UserSignupViewModel {
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final DateTime? birthDate;
  final String? gender;

  UserSignupViewModel(this.email, this.password, this.passwordConfirmation,
      this.birthDate, this.gender);

  factory UserSignupViewModel.newUser() {
    return UserSignupViewModel(null, null, null, null, null);
  }

  bool get emailIsValid => emailValidator(email) == null;

  bool get passwordIsValid => passwordValidator(password) == null;

  bool get birthDateIsValid => birthDateValidator(birthDate) == null;

  bool get passwordConfirmationIsValid =>
      passwordConfirmationValidator(passwordConfirmation) == null;

  bool get genderIsValid => genderValidator(gender) == null;

  bool isValid() =>
      emailIsValid &&
      passwordIsValid &&
      birthDateIsValid &&
      passwordConfirmationIsValid &&
      genderIsValid;

  String? genderValidator(String? s) {
    if (s == null || s.isWhiteSpace() || s == '') {
      return "Gender is required";
    }
  }

  String? emailValidator(String? s) {
    if (s == null || s.isWhiteSpace()) {
      return "Email is required";
    }

    if (!s.isValidEmail()) {
      return "Invalid email address";
    }
  }

  String? passwordConfirmationValidator(String? s) {
    if (s == null || s.isWhiteSpace()) {
      return "Password confirmation is required";
    }
    if (s != password) {
      return "Must match your password";
    }
  }

  String? passwordValidator(String? s) {
    if (s == null || s.isWhiteSpace()) {
      return "Password is required";
    }
    if (!s.isValidPassword()) {
      return "Your password isn't long enough";
    }
  }

  String? birthDateValidator(DateTime? s) {
    final now = DateTime.now();
    DateTime sixteenYearsAgo = now.subtract(Duration(days: 16 * 365));
    if (s == null) {
      return "Birth date is required";
    }
    if (!s.isBefore(DateTime(now.year, now.month, now.day))) {
      return "Birt dates cannot be in the future";
    }
    if (!s.isBefore(sixteenYearsAgo)) {
      return "Must be 16 or older to register";
    }
  }

  UserSignupViewModel copyWith(
      {String? email,
      String? password,
      String? passwordConfirmation,
      DateTime? birthDate,
      String? gender}) {
    return UserSignupViewModel(
        email ?? this.email,
        password ?? this.password,
        passwordConfirmation ?? this.passwordConfirmation,
        birthDate ?? this.birthDate,
        gender ?? this.gender);
  }
}
