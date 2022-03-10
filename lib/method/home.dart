import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:setes_ctaker/method/login.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/gb_data.dart';

getMatchs(props) async {
  String _id = uData["_id"];
  props.setState(() => props.error = null);
  try {
    var res = await http.get(
      getApi('matchs?ctaker_id=' + _id),
      headers: gbHeader,
    );
    if (res.statusCode == 200) {
      props.setState(() => props.matchs = jsonDecode(res.body));
    } else {
      if (res.statusCode == 401) {  
        logout(props.context);
      } else {
        props.setState(() => props.error = jsonDecode(res.body)['msg']);
      }
      return 0;
    }
  } catch (e) {
    props.setState(() => props.error = "Network Error");
  }
  props.setState(() => props.loading = false);
  return 0;
}
