import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/match.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/widget/counter.dart';
import 'package:http/http.dart' as http;

popupErr(context, msg) => showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(title: Text(msg));
    });

popupPlyers(props, item, title) {
  var auts = props.match["teams"];
  return showDialog<void>(
    context: props.context,
    builder: (BuildContext context) {
      Size scr = getScreen(context);
      return AlertDialog(
        title: Text("Chose Player ($title)"),
        content: SizedBox(
          height: scr.height * .7,
          width: scr.width * .8,
          child: ListView(
            children: [
              for (var i = 0; i < auts.length; i++)
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      var body = jsonEncode({
                        "match_id": props.match["_id"],
                        "item": item,
                        "who": auts[i],
                        "time": "10",
                        "title": title
                      });
                      var url = getApi('matchevent');
                      const head = {"Content-Type": "application/json"};
                      var res = await http.post(url, body: body, headers: head);
                      if (res.statusCode == 200) {
                        await getMatch(props);
                        const msg = 'Succesfully Updated';
                        popupErr(props.context, msg);
                      } else {
                        var msg = await jsonDecode(res.body)['msg'];
                        popupErr(props.context, msg);
                      }
                    } catch (e) {
                      const msg = 'ERROR:Try again by reloading the page.';
                      popupErr(props.context, msg);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: auts[i]["img"] == null
                                ? const Icon(Icons.person,
                                    size: 35, color: Colors.black54)
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(17.5)),
                                    child: Image.network(setUserPro(auts[i]),
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.contain),
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                auts[i]["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 14.5),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                auts[i]["id"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        auts[i]["team"] == "r" ? "Red" : "Blue",
                        style: TextStyle(
                          color:
                              auts[i]["team"] == "r" ? Colors.red : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

var ents = <Map>[
  {
    "icon": Icons.speed,
    "title": "Total shots",
    "fun": (props) {
      var shots = props.props.match["shots"];
      setb(v) => shots["b"] = v;
      setr(v) => shots["r"] = v;
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          Size scr = getScreen(context);
          return AlertDialog(
            title: const Text('Set shots'),
            content: Container(
                padding: const EdgeInsets.all(10),
                width: scr.width * .6,
                height: 125,
                child: Column(children: [
                  CounterButton(Colors.blue, i: shots["b"], fun: setb),
                  const SizedBox(height: 5),
                  CounterButton(Colors.red, i: shots["r"], fun: setr)
                ])),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String _id = props.props.match["_id"];
                  try {
                    var body = jsonEncode({"shots": shots});
                    var url = getApi('booking?booking_id=' + _id);
                    const head = {"Content-Type": "application/json"};
                    var res = await http.put(url, body: body, headers: head);
                    if (res.statusCode == 200) {
                      await getMatch(props.props);
                      const msg = 'Succesfully Updated';
                      popupErr(props.props.context, msg);
                    } else {
                      var msg = jsonDecode(res.body)['msg'];
                      popupErr(props.props.context, msg);
                    }
                  } catch (e) {
                    const msg = 'ERROR:Try again by reloading the page.';
                    popupErr(props.props.context, msg);
                  }
                },
                child: const Text('Update'),
              )
            ],
          );
        },
      );
    },
  },
  {
    "icon": Icons.power_settings_new,
    "title": "Average possession",
    "fun": (props) {
      var poss = props.props.match["possessions"];
      setb(v) => poss["b"] = v;
      setr(v) => poss["r"] = v;
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          Size scr = getScreen(context);
          return AlertDialog(
            title: const Text('Set possessions'),
            content: Container(
                padding: const EdgeInsets.all(10),
                width: scr.width * .6,
                height: 125,
                child: Column(children: [
                  CounterButton(Colors.blue, i: poss["b"], fun: setb),
                  const SizedBox(height: 5),
                  CounterButton(Colors.red, i: poss["r"], fun: setr)
                ])),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String _id = props.props.match["_id"];
                  try {
                    var body = jsonEncode({"possessions": poss});
                    var url = getApi('booking?booking_id=' + _id);
                    const head = {"Content-Type": "application/json"};
                    var res = await http.put(url, body: body, headers: head);
                    if (res.statusCode == 200) {
                      await getMatch(props.props);
                      const msg = 'Succesfully Updated';
                      popupErr(props.props.context, msg);
                    } else {
                      var msg = jsonDecode(res.body)['msg'];
                      popupErr(props.props.context, msg);
                    }
                  } catch (e) {
                    const msg = 'ERROR:Try again by reloading the page.';
                    popupErr(props.props.context, msg);
                  }
                },
                child: const Text('Update'),
              )
            ],
          );
        },
      );
    },
  },
  {
    "icon": Icons.flag,
    "title": "Corners",
    "fun": (props) {
      var corns = props.props.match["corners"];
      setb(v) => corns["b"] = v;
      setr(v) => corns["r"] = v;
      showDialog<void>(
        context: props.props.context,
        builder: (BuildContext context) {
          Size scr = getScreen(context);
          return AlertDialog(
            title: const Text('Set corners'),
            content: Container(
                padding: const EdgeInsets.all(10),
                width: scr.width * .6,
                height: 125,
                child: Column(children: [
                  CounterButton(Colors.blue, i: corns["b"], fun: setb),
                  const SizedBox(height: 5),
                  CounterButton(Colors.red, i: corns["r"], fun: setr)
                ])),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String _id = props.props.match["_id"];
                  try {
                    var body = jsonEncode({"corners": corns});
                    var url = getApi('booking?booking_id=' + _id);
                    const head = {"Content-Type": "application/json"};
                    var res = await http.put(url, body: body, headers: head);
                    if (res.statusCode == 200) {
                      await getMatch(props.props);
                      const msg = 'Succesfully Updated';
                      popupErr(props.props.context, msg);
                    } else {
                      var msg = jsonDecode(res.body)['msg'];
                      popupErr(props.props.context, msg);
                    }
                  } catch (e) {
                    const msg = 'ERROR:Try again by reloading the page.';
                    popupErr(props.props.context, msg);
                  }
                },
                child: const Text('Update'),
              )
            ],
          );
        },
      );
    },
  },
  {
    "icon": Icons.sports_baseball,
    "title": "Goals",
    "fun": (props) => popupPlyers(props.props, 'goals', "Goal"),
  },
  {
    "icon": Icons.card_membership,
    "title": "Fouls",
    "fun": (props) => popupPlyers(props.props, 'fouls', "Foul"),
  },
  {
    "icon": Icons.sports_football,
    "title": "Yellow cards",
    "fun": (props) => popupPlyers(props.props, 'ycs', "Yellow Card"),
  },
  {
    "icon": Icons.sports_football,
    "title": "Red cards",
    "fun": (props) => popupPlyers(props.props, 'rcs', "Red Card"),
  },
  {
    "icon": Icons.outbond,
    "title": "Off sides",
    "fun": (props) => popupPlyers(props.props, 'offsides', "OffSide"),
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
