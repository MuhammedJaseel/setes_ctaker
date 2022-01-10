import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/match.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/widget/counter.dart';
import 'package:http/http.dart' as http;

var ents = <Map>[
  {
    "icon": Icons.sports_baseball,
    "title": "Goals",
    "fun": (props) {
      var match = props.props.match;
      setgoalb(v) => match["goals"]["b"] = v;
      setgoalr(v) => match["goals"]["r"] = v;
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          Size scr = getScreen(context);
          return AlertDialog(
            title: const Text('Set Goal'),
            content: Container(
              padding: const EdgeInsets.all(10),
              width: scr.width * .6,
              height: 125,
              child: Column(
                children: [
                  CounterButton(
                    color: Colors.blue,
                    i: match["goals"]["b"],
                    fun: setgoalb,
                  ),
                  const SizedBox(height: 5),
                  CounterButton(
                    color: Colors.red,
                    i: match["goals"]["r"],
                    fun: setgoalr,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String _id = match["_id"];
                  try {
                    var body = {"goals": match["goals"]};
                    var res = await http.put(
                        getApi('booking?booking_id=' + _id),
                        body: jsonEncode(body),
                        headers: {"Content-Type": "application/json"});
                    if (res.statusCode == 200) {
                      await getMatch(props.props);
                      showDialog<void>(
                        context: props.props.context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                              title: Text('Succesfully Updated'));
                        },
                      );
                    } else {
                      showDialog<void>(
                        context: props.props.context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                              title: Text(
                                  'Something wrong on updating goal, try again by reloading the page.'));
                        },
                      );
                    }
                  } catch (e) {
                    showDialog<void>(
                      context: props.props.context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                            title: Text(
                                'Something wrong on updating goal, try again by reloading the page.'));
                      },
                    );
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    },
  },
  {
    "icon": Icons.speed,
    "title": "Total shots",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
  {
    "icon": Icons.power_settings_new,
    "title": "Average possession",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
  {
    "icon": Icons.card_membership,
    "title": "Fouls",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
  {
    "icon": Icons.sports_football,
    "title": "Yellow cards",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
  {
    "icon": Icons.sports_football,
    "title": "Red cards",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
  {
    "icon": Icons.outbond,
    "title": "Off sides",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
  {
    "icon": Icons.flag,
    "title": "Corners",
    "fun": (props) {
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Chose event'),
          );
        },
      );
    },
  },
];

class MatchEventadder extends StatelessWidget {
  final dynamic props;
  const MatchEventadder(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      padding: const EdgeInsets.all(15),
      width: scr.width * .6,
      height: scr.height * .5,
      child: ListView(
        children: [
          for (var i = 0; i < ents.length; i++)
            InkWell(
              onTap: () {
                Navigator.pop(context);
                ents[i]["fun"](this);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: Colors.black38),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ents[i]["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 14.5,
                      ),
                    ),
                    Icon(
                      ents[i]["icon"],
                      size: 17,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
