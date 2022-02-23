import 'dart:convert';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/gb_data.dart';
import 'package:http/http.dart' as http;

getAllMatch(props) async {
  props.setState(() => props.error = null);
  try {
    var res = await http.get(getApi('allmatchs?ctaker_id=' + uData['_id']));
    if (res.statusCode == 200) {
      props.setState(() => props.matchs = jsonDecode(res.body));
    } else {
      props.setState(() => props.error = jsonDecode(res.body)['msg']);
    }
  } catch (e) {
    props.setState(() => props.error = "Network error");
  }
  props.setState(() => props.loading = false);
  return 0;
}
