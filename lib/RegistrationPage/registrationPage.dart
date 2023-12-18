import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petpals_frontend/RegistrationPage/signup_form.dart';
import 'package:petpals_frontend/RegistrationPage/user_signup_view_model.dart';
import 'package:petpals_frontend/shared/bottomnavbar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var viewModel = UserSignupViewModel.newUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Form"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final isValid = formKey.currentState!.validate();

          print(viewModel.isValid());
          assert(isValid == viewModel.isValid(),
              "The view model and form must agree on wether the form is valid");

          print("Signup valid: $isValid\n$viewModel");
        },
        label: const Text("Sumbit"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: SignupForm(
          formkey: formKey,
          onChanged: (value) => setState(() => viewModel = value),
          viewModel: viewModel,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}


/* class GenderSelector extends StatefulWidget {
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? selectedGender;
  List<Map<String, dynamic>> genders = [];

  @override
  void initState() {
    super.initState();
    fetchGenders();
  }

  Future<void> fetchGenders() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5018/api/v1/genders'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> genderList = data
            .map((dynamic item) => Map<String, dynamic>.from(item))
            .toList();

        setState(() {
          genders = genderList;
        });

        print('Genders fetched successfully: $genders');
      } else {
        print('Failed to load genders. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching genders: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFD7BABA).withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedGender,
          hint: const Text('Select Gender'),
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
          items: genders
              .map<DropdownMenuItem<String>>((Map<String, dynamic> gender) {
            return DropdownMenuItem<String>(
              value: gender['name'],
              child: Text(gender['name']),
            );
          }).toList(),
        ),
      ),
    );
  }
}

 */