import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/gb_data.dart';
import 'package:setes_ctaker/screen/home.dart';
import 'package:setes_ctaker/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

login(props) async {
  props.setState(() {
    props.loading = true;
    props.error = null;
  });
  var body = {
    'user_name': props.widget.props.userNameC.text,
    'password': props.widget.props.passwordC.text
  };
  try {
    var res = await http.post(getApi('login'), body: body);
    if (res.statusCode == 200) {
      var data = await jsonDecode(res.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userId", data["_id"]);
      await prefs.setString("userName", data["user_name"]);
      await prefs.setBool("ifUser", true);
      uData = data;
      Navigator.pushReplacement(props.context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      props.setState(() => props.error = jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    props.setState(() => props.error = "Check Your Network");
  }
  props.setState(() => props.loading = false);
  return 0;
}

logout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("userId", "");
  await prefs.setString("userName", "");
  await prefs.setBool("ifUser", false);
  Navigator.pop(context);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}
