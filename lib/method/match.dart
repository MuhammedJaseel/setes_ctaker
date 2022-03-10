import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:setes_ctaker/method/login.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/gb_data.dart';
import 'package:setes_ctaker/screen/home.dart';
import 'package:setes_ctaker/screen/positioning.dart';
import 'package:setes_ctaker/widget/match_event_adder.dart';

getMatch(props, context) async {
  props.seterror(null);
  String _id = props.widget.props["_id"];
  try {
    var res = await http.get(
      getApi('match?booking_id=' + _id),
      headers: gbHeader,
    );
    if (res.statusCode == 200) {
      props.setmatch(await jsonDecode(res.body));
    } else {
      if (res.statusCode == 401) {
        logout(context);
      } else {
        props.seterror("Error On Loading data");
      }
    }
  } catch (e) {
    props.seterror("Network Error");
  }
  props.setloading(false);
  return 0;
}

matchInitialLoad(props) async {
  await getMatch(props, props.context);
  props.setstatus(props.match["status"]);

  if (props.status == "Started") {
    var start = props.match["starting_time"];
    var tes = DateTime.parse(start);
    var d = DateTime.now().difference(tes);
    var hd = d.inHours;
    var md = d.inMinutes % 60;
    var sd = d.inSeconds % 60;

    if (hd < 3) {
      props.set_timer(Timer.periodic(const Duration(seconds: 1), (timer) {
        sd++;
        if (sd == 61) {
          sd = 1;
          md++;
        }
        if (md == 61) {
          md = 1;
          hd++;
        }
        props.setmatchtimer('$hd:$md:$sd');
      }));
    }
  }
  if (props.status == "Fulltime") {
    var start = props.match["starting_time"];
    var end = props.match["ending_time"];
    var d = DateTime.parse(end).difference(DateTime.parse(start));
    var hd = d.inHours;
    var md = d.inMinutes % 60;
    var sd = d.inSeconds % 60;
    props.setmatchtimer('$hd:$md:$sd');
  }
}

cancelMatch(props) {
  showDialog<void>(
    context: props.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'If you cancel the match, then you cannot take it back.',
        ),
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
                  await getMatch(props.widget.props, context);
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

startPositioning(props) {
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
  Navigator.push(
    props.context,
    MaterialPageRoute(
      builder: (context) => PositioningPage(props.widget.props.match),
    ),
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
              String _id = props.widget.match["_id"];
              var aut = props.widget.match['authers'];
              for (var i = 0; i < aut.length; i++) {
                if (aut[i]['pos_xy'] == null) {
                  props.setState(() => props.error = "Position all members");
                  return;
                }
              }
              props.setState(() {
                props.loading = false;
                props.error = null;
              });
              try {
                var body = {"status": "Started", "teams": aut};
                var res = await http.put(
                  getApi('booking?booking_id=' + _id),
                  body: jsonEncode(body),
                  headers: gbHeader,
                );
                if (res.statusCode == 200) {
                  Navigator.pop(context);
                  Navigator.push(
                    props.context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                } else {
                  if (res.statusCode == 401) {
                    logout(context);
                  } else {
                    props.setState(() => props.error = "Error On Loading data");
                  }
                }
              } catch (e) {
                props.setState(() => props.error = "Network Error");
              }
              props.setState(() => props.loading = false);
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
                var res = await http.put(
                  getApi('booking?booking_id=' + _id),
                  body: body,
                  headers: gbHeader,
                );
                if (res.statusCode == 200) {
                  await getMatch(props.widget.props, context);
                } else {
                  if (res.statusCode == 401) {
                    logout(context);
                  } else {
                    props.seterror("Error On Loading data");
                  }
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
        title: const Text('Chose event'),
        content: MatchEventadder(props.widget.props),
      );
    },
  );
}

updateMatchEvent() {}
