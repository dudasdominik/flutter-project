import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petpals_frontend/Entities/user.dart';
import 'package:petpals_frontend/RegistrationPage/registrationPage.dart';

import 'package:petpals_frontend/shared/bottomnavbar.dart';
import 'package:http/http.dart' as http;

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var response = await http.get(
    Uri.parse("http://10.0.2.2:5018/api/v1/users"),
  );

  if (response.statusCode == 200) {
    var users = jsonDecode(response.body) as List<dynamic>;
    var userList = users.map((user) => User.fromJson(user)).toList();
    userList.forEach((element) {
      print(element.userName);
    });
  } else {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegistrationPage());
  }
}
