import 'dart:async';
import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/match.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/screen/warnings.dart';
import 'package:setes_ctaker/widget/match_wigets.dart';
import 'package:setes_ctaker/widget/pull_reload.dart';

class MatchScreen extends StatefulWidget {
  final Map props;
  const MatchScreen(this.props, {Key? key}) : super(key: key);
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  Map match = {};
  setmatch(v) => setState(() => match = v);
  bool loading = true;
  setloading(v) => setState(() => loading = v);
  String? error;
  seterror(v) => setState(() => error = v);

  String status = "";
  setstatus(v) => setState(() => status = v);
  String goals = ". - .";
  setgoals(v) => setState(() => goals = v);
  String matchtimer = "";
  setmatchtimer(v) => setState(() => matchtimer = v);

  Timer? _timer;
  set_timer(v) => _timer = v;

  @override
  void initState() {
    matchInitialLoad(this);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    if (!loading) {
      if (status == "Started" || status == "Fulltime") {
        setgoals(match["goals"]["r"].toString() +
            " - " +
            match["goals"]["b"].toString());
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.props["slot"]["truf_name"])),
      body: loading
          ? const Loading()
          : error == null
              ? Column(
                  children: [
                    Expanded(
                      child: PullReloadPage(
                        Container(
                          constraints: BoxConstraints(
                            minHeight: scr.height - 145,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 22,
                          ),
                          child: MatchBody(this),
                        ),
                        () => getMatch(this),
                        () {},
                      ),
                    ),
                    if (match["status"] == "Cancelled")
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          match["status"] ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      )
                    else
                      MatchBottom(this),
                  ],
                )
              : ErrorBody(error: error ?? ''),
    );
  }
}

class MatchBody extends StatelessWidget {
  final dynamic props;
  const MatchBody(this.props, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    var slot = props.widget.props["slot"];
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: scr.width * .7,
              child: Text(
                slot["truf_name"],
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16),
              ),
            ),
            Text(
              (slot["price"] / 100).toString() + "/-",
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ground: " + slot["ground"],
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontSize: 13),
            ),
            Text(
              "Time : " + slot["s_time"] + " - " + slot["e_time"],
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                  fontSize: 13),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: scr.width * .7,
              child: Text(
                props.match["truf"] == null
                    ? ""
                    : props.match["truf"]["location"] ?? "",
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13),
              ),
            ),
            Text(
              props.widget.props["date"],
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                  fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Goals(Red - Blue) : " + props.goals,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            Text(
              props.matchtimer,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        MatchPlyers(this),
      ],
    );
  }
}

class MatchPlyers extends StatelessWidget {
  final dynamic props;
  const MatchPlyers(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List authers;
    if (props.props.match["status"] == "Fulltime" ||
        props.props.match["status"] == "Started") {
      authers = props.props.match["teams"] ?? [];
    } else {
      authers = props.props.match["authers"] ?? [];
    }
    Size scr = getScreen(context);
    return Container(
      padding: EdgeInsets.all(scr.height * .015),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1.5, color: Colors.black12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Play List",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              Icon(Icons.layers_rounded, size: 40, color: Color(0xffCF595A)),
            ],
          ),
          if (authers.isNotEmpty)
            for (var i = 0; i < authers.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(authers[i]['name']),
                            content: SizedBox(
                              height: 120,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("ID"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          authers[i]['id'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Phone"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          authers[i]['Phone'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Position"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          authers[i]['fav_position'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Position II"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          authers[i]['sec_fav_position'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Prime"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          (authers[i]['prime'] ?? false)
                                              ? "YES"
                                              : "NO",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 43,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          child: authers[i]["img"] == null
                              ? const Icon(Icons.person,
                                  size: 35, color: Colors.black54)
                              : ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(17.5),
                                  ),
                                  child: Image.network(
                                    setUserPro(authers[i]),
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, exception, stackTrace) =>
                                            Image.asset(
                                      "asset/img_crack.jpg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authers[i]["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 14.5),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              authers[i]["id"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (props.props.match["status"] == "Fulltime" ||
                      props.props.match["status"] == "Started")
                    Text(
                      authers[i]["team"] == "r" ? "Team Red" : "Team Blue",
                      style: TextStyle(
                        color: authers[i]["team"] == "r"
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  if (props.props.match["status"] == "Booked")
                    Row(
                      children: [
                        SizedBox(
                          width: 35,
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.blue),
                            child: Checkbox(
                              value: authers[i]["team"] == "b" ? true : false,
                              activeColor: Colors.blue,
                              onChanged: (v) {
                                var match = props.props.match;
                                match["authers"][i]["team"] = "b";
                                props.props.setmatch(match);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.red),
                            child: Checkbox(
                              value: authers[i]["team"] == "r" ? true : false,
                              activeColor: Colors.red,
                              onChanged: (v) {
                                var match = props.props.match;
                                match["authers"][i]["team"] = "r";
                                props.props.setmatch(match);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
          if (authers.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 80),
                Text(
                  "No Players",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class MatchBottom extends StatefulWidget {
  final dynamic props;
  const MatchBottom(this.props, {Key? key}) : super(key: key);

  @override
  _MatchBottomState createState() => _MatchBottomState();
}

class _MatchBottomState extends State<MatchBottom> {
  bool loading = false;
  setloading(v) => setState(() => loading = v);
  String? error;
  seterror(v) => setState(() => error = v);

  @override
  Widget build(BuildContext context) {
    String status = widget.props.match['status'];
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          if (error != null)
            Text(
              error ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          if (error != null) const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (status == "Started" || status == "Fulltime")
                BottomButton(
                    loading ? "..." : "Add Event", () => addMatchEvent(this)),
              if (status == "Started")
                BottomButton(
                    loading ? "..." : "Stop Match", () => stopMatch(this)),
              if (status == "Booked" || status == "Fulltime")
                BottomButton(
                    loading ? "..." : "LineUp", () => startPositioning(this)),
              if (status == "Booked")
                BottomButton(
                    loading ? "..." : "Cancel", () => cancelMatch(this)),
            ],
          ),
        ],
      ),
    );
  }
}
