import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:setes_ctaker/module/api.dart';

getMatch(props) async {
  props.seterror(null);
  String _id = props.widget.props["_id"];
  try {
    var res = await http.get(getApi('match?booking_id=' + _id));
    if (res.statusCode == 200) {
      props.setmatch(await jsonDecode(res.body));
    } else {
      props.seterror("Error On Loading data");
    }
  } catch (e) {
    props.seterror("Network Error");
  }
  props.setloading(false);
  return 0;
}

reloadMatch(props) async {
  props.seterror(null);
  String _id = props.widget.props["_id"];
  try {
    var res = await http.get(getApi('match?booking_id=' + _id));
    if (res.statusCode == 200) {
      props.setmatch(await jsonDecode(res.body));
    } else {
      props.seterror("Error On Loading data");
    }
  } catch (e) {
    props.seterror("Network Error");
  }
  props.setloading(false);
  return 0;
}

cancelMatch(props) {
  showDialog<void>(
    context: props.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
            'If you cancel the match, then you cannot take it back.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              props.seterror(null);
              props.setloading(true);
              String bookingId = props.widget.props.match["_id"];
              try {
                var body = {"status": "Canceled"};
                var res = await http
                    .put(getApi('booking?booking_id=' + bookingId), body: body);
                if (res.statusCode == 200) {
                  await getMatch(props.widget.props);
                } else {
                  props.seterror("Error On Loading data");
                }
              } catch (e) {
                props.seterror("Network Error");
              }
              props.setloading(false);
            },
            child: const Text('Confirm Cancel'),
          ),
        ],
      );
    },
  );
}

startMatch(props) {
  showDialog<void>(
    context: props.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Once you start match, then you cannot take it back.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              props.seterror(null);
              props.setloading(true);
              var authers = props.widget.props.match["authers"];
              for (var i = 0; i < authers.length; i++) {
                if (!authers[i].containsKey("team")) {
                  props.seterror("Assign team to all members");
                  props.setloading(false);
                  return;
                }
              }
              String _id = props.widget.props.match["_id"];
              try {
                var body = {"status": "Started", "teams": authers};
                var res = await http.put(getApi('booking?booking_id=' + _id),
                    body: jsonEncode(body),
                    headers: {"Content-Type": "application/json"});
                if (res.statusCode == 200) {
                  await getMatch(props.widget.props);
                } else {
                  props.seterror("Error On Loading data");
                }
              } catch (e) {
                props.seterror("Network Error");
              }
              props.setloading(false);
            },
            child: const Text('Confirm Start'),
          ),
        ],
      );
    },
  );
}

stopMatch(props) async {
  showDialog<void>(
    context: props.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Once you stop match, then you cannot take it back.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              props.seterror(null);
              props.setloading(true);
              String _id = props.widget.props.match["_id"];
              try {
                var body = {"status": "Fulltime"};
                var res = await http.put(getApi('booking?booking_id=' + _id),
                    body: body);
                if (res.statusCode == 200) {
                  await getMatch(props.widget.props);
                } else {
                  props.seterror("Error On Loading data");
                }
              } catch (e) {
                props.seterror("Network Error");
              }
              props.setloading(false);
            },
            child: const Text('Confirm Stop'),
          ),
        ],
      );
    },
  );
}

addMatchEvent(props) async {
  showDialog<void>(
    context: props.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
            'If you cancel the match, then you cannot take it back.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              props.setloading(true);
              props.seterror(null);
              String _id = props.widget.props.match["_id"];
              try {
                var body = {};
                var res = await http.put(getApi('booking?booking_id=' + _id),
                    body: body);
                if (res.statusCode == 200) {
                  await getMatch(props.widget.props);
                } else {
                  props.seterror("Error On Loading data");
                }
              } catch (e) {
                props.seterror("Network Error");
              }
              props.setloading(false);
            },
            child: const Text('Confirm Cancel'),
          ),
        ],
      );
    },
  );
}
