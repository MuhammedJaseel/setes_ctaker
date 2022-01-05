import 'package:flutter/material.dart';

class PullReloadPage extends StatefulWidget {
  final Widget body;
  final Function refresh;
  final Function loadmore;
  const PullReloadPage(this.body, this.refresh, this.loadmore, {Key? key})
      : super(key: key);

  @override
  _PullReloadPageState createState() => _PullReloadPageState();
}

class _PullReloadPageState extends State<PullReloadPage> {
  final ScrollController homeC = ScrollController();
  bool loadtop = false;
  bool loaddown = false;
  refresh() async {
    setState(() => loadtop = true);
    await widget.refresh();
    setState(() => loadtop = false);
    return;
  }

  loadmore() async {
    setState(() => loaddown = true);
    await widget.loadmore();
    setState(() => loaddown = false);
    return;
  }

  Widget loadingIcon = const SizedBox(
    height: 60,
    child: Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: SingleChildScrollView(
        controller: homeC,
        child: Column(
          children: [
            if (loadtop) loadingIcon,
            widget.body,
            if (loaddown) loadingIcon,
          ],
        ),
      ),
      onNotification: (Notification t) {
        if (t is OverscrollNotification) {
          OverscrollNotification ov = t;
          if ((!loadtop) && (ov.overscroll < -20)) refresh();
          if ((!loaddown) && (ov.overscroll > 20)) loadmore();
        }
        return true;
      },
    );
  }
}
