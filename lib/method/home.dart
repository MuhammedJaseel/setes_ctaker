import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:setes_ctaker/module/api.dart';

getMatchs(props) async {
  String _id = props.widget.uData["_id"];

  try {
    var res = await http.get(getApi('matchs?ctaker_id=' + _id));
    if (res.statusCode == 200) {
      props.setmatchs(await jsonDecode(res.body));
    } else {
      props.seterror("Error On Loading data");
    }
  } catch (e) {
    props.seterror("Network Error");
  }
  props.setloading(false);

  return 0;
}

rloadMatchs(props) async {
  String _id = props.widget.uData["_id"];

  try {
    var res = await http.get(getApi('matchs?ctaker_id=' + _id));
    if (res.statusCode == 200) {
      props.setmatchs(await jsonDecode(res.body));
    } else {
      props.seterror("Error On Loading data");
    }
  } catch (e) {
    props.seterror("Network Error");
  }
  props.setloading(false);
  return 0;
}
