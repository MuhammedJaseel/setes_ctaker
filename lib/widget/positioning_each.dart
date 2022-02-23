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
    var autR = [];
    var autB = [];
    String? sId;
    if (props.selected != null) sId = props.selected['_id'];

    for (var i = 0; i < autT.length; i++) {
      if (autT[i]['pos_xy'] == null) {
        if (autT[i]['team'] == 'r') {
          autR.add(autT[i]);
        } else {
          autB.add(autT[i]);
        }
      }
    }

    return Container(
      color: Colors.green[900],
      child: ListView(
        children: [
          const SizedBox(height: 20),
          for (var i = 0; i < autR.length; i += 5)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var j = 0; ((j < 5) && (i + j < autR.length)); j++)
                      InkWell(
                        onTap: () =>
                            props.setState(() => props.selected = autR[i + j]),
                        child: PositioningEachPlayers(autR[i + j], sId),
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
                for (var x = 0; x < 11; x++)
                  for (var y = 0; y < 21; y++)
                    Positioned(
                      top: gh / 21 * y,
                      left: gw / 11 * x,
                      height: gh / 21,
                      width: gw / 11,
                      child: InkWell(
                        onTap: () {
                          if (sId != null) {
                            for (var i = 0; i < autT.length; i++) {
                              if (sId == autT[i]['_id']) {
                                if (autT[i]['team'] == 'r' && y > 9) return;
                                if (autT[i]['team'] == 'b' && y < 11) return;
                                var aut = props.authers;
                                aut[i]['pos_name'] = "Player";
                                aut[i]['pos_xy'] = {
                                  "x": (x / 11) + 0.05,
                                  "y": (y / 21) + 0.025
                                };
                                props.setState(() {
                                  props.selected = null;
                                  props.authers = aut;
                                });
                                break;
                              }
                            }
                          }
                        },
                      ),
                    ),
                for (var i = 0; i < autT.length; i++)
                  if (autT[i]['pos_xy'] != null)
                    Positioned(
                      top: (autT[i]['pos_xy']['y'] * gh) - (scr.width * .07),
                      left: (autT[i]['pos_xy']['x'] * gw) - (scr.width * .07),
                      child: InkWell(
                        onTap: () {
                          if (autT[i]['pos_name'] != 'Keeper') {
                            props.setState(() => props.selected = autT[i]);
                          }
                        },
                        child: PositioningEachPlayers(autT[i], sId),
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < autB.length; i += 5)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var j = 0; ((j < 5) && (i + j < autB.length)); j++)
                      InkWell(
                        onTap: () =>
                            props.setState(() => props.selected = autB[i + j]),
                        child: PositioningEachPlayers(autB[i + j], sId),
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
  final String? selected;
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: scr.width * .03),
          ),
        ],
      ),
    );
  }
}
