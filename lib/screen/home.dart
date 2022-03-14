import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/home.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/gb_data.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/screen/warnings.dart';
import 'package:setes_ctaker/widget/home_drower.dart';
import 'package:setes_ctaker/widget/home_match.dart';
import 'package:setes_ctaker/widget/pull_reload.dart';

import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List matchs = [];
  bool loading = true;
  String? error;

  connectSocket() {
    var channel = IOWebSocketChannel.connect(wsUrl(uData["_id"] ?? ''));
    channel.stream.listen(
      (message) => getMatchs(this),
      onDone: () => Future.delayed(const Duration(seconds: 10), connectSocket),
      onError: (e) =>
          Future.delayed(const Duration(seconds: 10), connectSocket),
    );
  }

  @override
  void initState() {
    getMatchs(this);
    connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      drawer: HomeDrower(uData),
      appBar: AppBar(title: const Text("Setes Caretaker")),
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
                    () => getMatchs(this),
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
        for (var i = 0; i < props.matchs.length; i++)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 3,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: scr.width * .5 - 60,
                      height: .6,
                      color: Colors.black38,
                    ),
                    Text(
                      props.matchs[i]["title"],
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      width: scr.width * .5 - 60,
                      height: .6,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              for (var j = 0; j < props.matchs[i]["data"].length; j++)
                HomeMatchEach(props.matchs[i]["data"][j]),
              if (props.matchs[i]["data"].length == 0)
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
          ),
      ],
    );
  }
}
