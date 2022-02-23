import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/matchs.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/screen/warnings.dart';
import 'package:setes_ctaker/widget/home_match.dart';
import 'package:setes_ctaker/widget/pull_reload.dart';

class MatchsScreen extends StatefulWidget {
  const MatchsScreen({Key? key}) : super(key: key);
  @override
  _MatchsScreenState createState() => _MatchsScreenState();
}

class _MatchsScreenState extends State<MatchsScreen> {
  List matchs = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    getAllMatch(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      appBar: AppBar(title: const Text("My Matchs")),
      body: loading
          ? const Loading()
          : error == null
              ? SizedBox(
                  width: scr.width,
                  height: scr.height,
                  child: PullReloadPage(
                    Container(
                      constraints: BoxConstraints(minHeight: scr.height - 60),
                      child: HomeBody(this),
                    ),
                    () => getAllMatch(this),
                    () {},
                  ),
                )
              : ErrorBody(error: error ?? ''),
    );
  }
}

class HomeBody extends StatelessWidget {
  final dynamic props;
  const HomeBody(this.props, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: [
        const SizedBox(height: 15),
        for (var j = 0; j < props.matchs.length; j++)
          HomeMatchEach(props.matchs[j]),
        if (props.matchs.length == 0)
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "No Match",
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
