import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GenderForm extends StatefulWidget {
  final ValueChanged<String> onChanged;
  String? currentValue;
  final FormFieldValidator<String>? validator;
  final String label;
  List<Map<String, dynamic>>? genders;

  GenderForm({
    super.key,
    this.currentValue,
    this.validator,
    required this.label,
    this.genders,
    required this.onChanged,
  });

  @override
  State<GenderForm> createState() => _GenderFormState();
}

class _GenderFormState extends State<GenderForm> {
  late Future<List<Map<String, dynamic>>> _fetchGendersFuture;
  @override
  void initState() {
    super.initState();
    _fetchGendersFuture = fetchGenders();
    print(fetchGenders());
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.currentValue,
      validator: widget.validator,
      builder: (formState) {
        late InputBorder shape;
        if (formState.hasError) {
          shape = Theme.of(context).inputDecorationTheme.errorBorder ??
              const OutlineInputBorder();
        } else {
          shape = Theme.of(context).inputDecorationTheme.enabledBorder ??
              const OutlineInputBorder();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchGendersFuture,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // Show a loading indicator while fetching
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                // Data is successfully fetched, build your UI here
                widget.genders = snapshot.data;

                return _buildGenderSelector(shape, formState);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildGenderSelector(
      InputBorder shape, FormFieldState<String> formState) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD7BABA).withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Stack(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchGendersFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  widget.genders = snapshot.data;
                }

                if (widget.genders == null) {
                  return const CircularProgressIndicator();
                }

                return _buildDropdownButton(formState);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(FormFieldState<String> formState) {
    return DropdownButton<String>(
      isExpanded: true,
      value: widget.currentValue,
      hint: Text(widget.currentValue ?? "Select a gender"),
      onChanged: (String? newValue) {
        widget.currentValue = newValue!;
        if (widget.currentValue != null) {
          widget.onChanged(widget.currentValue!);
          formState.didChange(widget.currentValue);
        }
      },
      items: widget.genders!
          .map<DropdownMenuItem<String>>((Map<String, dynamic> gender) {
        return DropdownMenuItem<String>(
          value: gender['name'],
          child: Text(gender['name']),
        );
      }).toList(),
    );
  }

  Future<List<Map<String, dynamic>>> fetchGenders() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5018/api/v1/genders'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> genderList = data
            .map((dynamic item) => Map<String, dynamic>.from(item))
            .toList();

        print('Genders fetched successfully: ${genderList}');
        return genderList;
      } else {
        print('Failed to load genders. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching genders: $error');
    }
    return [];
  }
}
