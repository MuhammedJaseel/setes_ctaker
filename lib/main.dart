import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/screen/home.dart';
import 'package:setes_ctaker/screen/login.dart';
import 'package:setes_ctaker/screen/warnings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setes Caretaker',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeConfig(),
    );
  }
}

class HomeConfig extends StatelessWidget {
  HomeConfig({Key? key}) : super(key: key);
  Widget page = const LoadingPage();
  config() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool ifuser = prefs.getBool('ifUser') ?? false;
      if (ifuser) {
        String _id = prefs.getString('userId') ?? "";
        var res = await http.get(getApi('profile?ctaker_id=' + _id));
        if (res.statusCode == 200) {
          page = HomeScreen(await jsonDecode(res.body));
        } else {
          page = const ErrorPage();
        }
      } else {
        page = LoginScreen();
      }
    } catch (e) {
      page = const ErrorPage();
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: config(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return page;
        } else {
          return const LoadingPage();
        }
      },
    );
  }
}
