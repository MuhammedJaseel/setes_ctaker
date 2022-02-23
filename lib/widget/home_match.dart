import 'package:flutter/material.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/screen/match.dart';
import 'package:setes_ctaker/widget/match_started.dart';

class HomeMatchEach extends StatelessWidget {
  final dynamic match;
  const HomeMatchEach(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MatchScreen(match)),
      ),
      child: Container(
        width: scr.width,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          gradient:
              LinearGradient(colors: [Color(0xffCE5859), Color(0xffEF8464)]),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3), blurRadius: 30, color: Colors.black12)
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match["slot"]["truf_name"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Text(
                  match["slot"]["truf_id"],
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            StartedStatus(match),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match["slot"]["ground"],
                  style: const TextStyle(color: Colors.black38, fontSize: 12),
                ),
                Text(
                  match["slot"]["s_time"] + "-" + match["slot"]["e_time"],
                  style: const TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
