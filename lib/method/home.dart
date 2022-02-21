import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:setes_ctaker/module/api.dart';

getMatchs(props) async {
  String _id = props.widget.uData["_id"];
  props.setState(() => props.error = null);
  try {
    var res = await http.get(getApi('matchs?ctaker_id=' + _id));
    if (res.statusCode == 200) {
      props.setState(() => props.matchs = jsonDecode(res.body));
    } else {
      props.setState(() => props.error = jsonDecode(res.body)['msg']);
      return 0;
    }
  } catch (e) {
    props.setState(() => props.error = "Network Error");
  }
  props.setState(() => props.loading = false);
  return 0;
}
