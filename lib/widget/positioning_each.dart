import 'package:flutter/material.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/simple.dart';

class PositioningEach extends StatelessWidget {
  final dynamic props;
  const PositioningEach(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    double gw = scr.width - 20;
    double gh = gw * 1.5;
    var autT = props.authers;
    var aut = [];
    String sId = props.selected == null ? '' : props.selected['_id'];

    for (var i = 0; i < autT.length; i++) {
      if (autT[i]['pos_xy'] == null) aut.add(autT[i]);
    }

    return Container(
      color: Colors.green[900],
      child: ListView(
        children: [
          const SizedBox(height: 20),
          for (var i = 0; i < aut.length; i += 5)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var j = 0; ((j < 5) && (i < aut.length)); j++)
                      if (aut[i + j]['team'] == "r")
                        InkWell(
                          onTap: () =>
                              props.setState(() => props.selected = aut[i + j]),
                          child: PositioningEachPlayers(aut[i + j], sId),
                        )
                  ],
                ),
                SizedBox(height: scr.width * .07)
              ],
            ),
          Container(
            height: gh,
            width: gw,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: gh / 2 - 1,
                  left: 0,
                  right: 0,
                  height: 2,
                  child: Container(color: Colors.white),
                ),
                for (var i = 0; i < 2; i++)
                  Positioned(
                    top: i == 0 ? -2 : null,
                    bottom: i == 1 ? -2 : null,
                    left: gw * .35,
                    width: gw * .30,
                    height: gh * .1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                    ),
                  ),
                for (var i = 0; i < 11; i++)
                  for (var j = 0; j < 21; j++)
                    Positioned(
                        top: gh / 21 * j,
                        left: gw / 11 * i,
                        height: gh / 21,
                        width: gw / 11,
                        child: InkWell(
                          onTap: () {
                            // if (sId != null) {
                            //   for (var i = 0; i < autT.length; i++) {
                            //     if (sId == autT['_id']) {
                            //       props.setState(() {
                            //         props.selected = null;
                            //         props.authers[i]['pos_name'] = "Player";
                            //         props.authers[i]
                            //             ['pos_xy'] = {"x": .1, "y": .2};
                            //       });
                            //       break;
                            //     }
                            //   }
                            // }
                          },
                        ))
              ],
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < aut.length; i += 5)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var j = 0; ((j < 5) && (i < aut.length)); j++)
                      if (aut[i + j]['team'] == "b")
                        InkWell(
                          onTap: () =>
                              props.setState(() => props.selected = aut[i + j]),
                          child: PositioningEachPlayers(aut[i + j], sId),
                        )
                  ],
                ),
                SizedBox(height: scr.width * .07)
              ],
            ),
        ],
      ),
    );
  }
}

class PositioningEachPlayers extends StatelessWidget {
  final Map user;
  final String selected;
  const PositioningEachPlayers(this.user, this.selected, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return SizedBox(
      width: scr.width * .14,
      height: scr.width * .14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: scr.width * .1,
            height: scr.width * .1,
            decoration: BoxDecoration(
              boxShadow: [
                if (selected == user["_id"])
                  BoxShadow(
                    color: user['team'] == "r" ? Colors.orange : Colors.blue,
                    spreadRadius: 0,
                    blurRadius: 8,
                  ),
              ],
              color: Colors.green[900],
              borderRadius: BorderRadius.all(Radius.circular(scr.width * .05)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(scr.width * .05)),
              child: user['img'] == null
                  ? Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(scr.width * .005),
                      child: Text(
                        user['id'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: scr.width * .02,
                        ),
                      ),
                    )
                  : Image.network(
                      setUserProfile(user['_id'], user['img']),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Text(
            user['name'],
            style: TextStyle(color: Colors.white, fontSize: scr.width * .03),
          ),
        ],
      ),
    );
  }
}
