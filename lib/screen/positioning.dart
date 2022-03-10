import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/match.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/widget/match_wigets.dart';
import 'package:setes_ctaker/widget/positioning_each.dart';
import 'package:setes_ctaker/widget/positioning_keeper.dart';

class PositioningPage extends StatefulWidget {
  final Map match;
  const PositioningPage(this.match, {Key? key}) : super(key: key);

  @override
  _PositioningPageState createState() => _PositioningPageState();
}

class _PositioningPageState extends State<PositioningPage> {
  Map match = {};
  List authers = [];
  int? keeperR;
  int? keeperB;
  int page = 0;
  bool loading = false;
  String? error;
  Map? selected;

  @override
  void initState() {
    match = widget.match;
    authers = match['authers'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Align players Position")),
      body: Column(
        children: [
          SizedBox(
            height: scr.height - 155,
            width: scr.width,
            child: page == 0 ? PositioningKeeper(this) : PositioningEach(this),
          ),
          SizedBox(
            height: 20,
            child: Center(
              child: Text(
                error ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                height: 55,
                child: BottomButton(page == 0 ? "Confirm" : "Start", () {
                  if (page == 0) {
                    if (keeperB != null && keeperR != null) {
                      setState(() {
                        page = 1;
                        widget.match["authers"][keeperB]["pos_name"] = "Keeper";
                        widget.match["authers"][keeperR]["pos_name"] = "Keeper";
                        widget.match["authers"][keeperB]
                            ["pos_xy"] = {"x": 0.5, "y": 0.92};
                        widget.match["authers"][keeperR]
                            ["pos_xy"] = {"x": 0.5, "y": 0.08};
                      });
                    } else {
                      setState(() => error = "Choose both keepers");
                    }
                  } else {
                    startMatch(this);
                  }
                }),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                height: 55,
                child: BottomButton("Clear", () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PositioningPage(match)));
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
