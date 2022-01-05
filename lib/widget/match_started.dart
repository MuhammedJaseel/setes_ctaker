import 'dart:async';
import 'package:flutter/material.dart';

class StartedStatus extends StatefulWidget {
  final Map props;
  const StartedStatus(this.props, {Key? key}) : super(key: key);

  @override
  _StartedStatusState createState() => _StartedStatusState();
}

class _StartedStatusState extends State<StartedStatus> {
  String status = "";
  String goals = ". - .";
  String matchtimer = "";

  Timer? _timer;

  @override
  void initState() {
    status = widget.props["status"];
    if (status == "Started" || status == "Fulltime") {
      goals = widget.props["goals"]["r"].toString() +
          " - " +
          widget.props["goals"]["b"].toString();
    }
    if (status == "Started") {
      var start = widget.props["starting_time"];
      var tes = DateTime.parse(start);
      var d = DateTime.now().difference(tes);
      var hd = d.inHours;
      var md = d.inMinutes % 60;
      var sd = d.inSeconds % 60;

      if (hd < 3) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          sd++;
          if (sd == 61) {
            sd = 1;
            md++;
          }
          if (md == 61) {
            md = 1;
            hd++;
          }
          setState(() => matchtimer = '$hd:$md:$sd');
        });
      }
    }
    if (status == "Fulltime") {
      var start = widget.props["starting_time"];
      var end = widget.props["ending_time"];
      var d = DateTime.parse(end).difference(DateTime.parse(start));
      var hd = d.inHours;
      var md = d.inMinutes % 60;
      var sd = d.inSeconds % 60;
      setState(() => matchtimer = '$hd:$md:$sd');
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (status == "Canceled")
          const Text(
            "Match Canceled",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
          ),
        if (status == "Started" || status == "Fulltime")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Goals(Red - Blue) : " + goals,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              Text(
                matchtimer + " " + status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        if (status == "Started" || status == "Fulltime")
          const SizedBox(height: 4),
      ],
    );
  }
}
