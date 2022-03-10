import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/gb_data.dart';
import 'package:setes_ctaker/module/get_gps.dart';
import 'package:setes_ctaker/screen/home.dart';
import 'package:setes_ctaker/screen/login.dart';
import 'package:setes_ctaker/screen/warnings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setes Caretaker',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeConfig(),
    );
  }
}

class HomeConfig extends StatelessWidget {
  const HomeConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget page = const LoadingPage();
    config() async {
      try {
        gbGPS = await determinePosition();
      } catch (e) {}
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool ifuser = prefs.getBool('ifUser') ?? false;
        if (ifuser) {
          String _id = prefs.getString('userId') ?? "";
          String authKey = prefs.getString('auth_key') ?? "";
          gbHeader = {
            'Content-Type': 'application/json',
            'user_id': _id,
            "key": authKey,
            "version": "1.0",
            'gps': "${gbGPS.latitude},${gbGPS.longitude}",
          };
          var res = await http.get(
            getApi('profile?ctaker_id=' + _id),
            headers: gbHeader,
          );
          if (res.statusCode == 200) {
            uData = await jsonDecode(res.body);
            page = const HomeScreen();
          } else {
            if (res.statusCode == 401) {
              page = LoginScreen();
            } else {
              page = const ErrorPage();
            }
          }
        } else {
          page = LoginScreen();
        }
      } catch (e) {
        page = const ErrorPage();
      }
      return 0;
    }

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
