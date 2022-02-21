import 'package:flutter/material.dart';

class PositioningKeeper extends StatelessWidget {
  final dynamic props;
  const PositioningKeeper(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          for (var p = 0; p < 2; p++)
            Column(
              children: [
                if (p == 1) const SizedBox(height: 10),
                Text(
                  "Chose Keeper for team " + (p == 0 ? "RED" : "BLUE"),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                for (var i = 0; i < props.authers.length; i++)
                  if (props.authers[i]['team'] == (p == 0 ? 'r' : 'b'))
                    InkWell(
                      onTap: () => props.setState(() {
                        if (p == 0) {
                          props.keeperR = i;
                        } else {
                          props.keeperB = i;
                        }
                      }),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: (p == 0 ? props.keeperR : props.keeperB) ==
                                  i
                              ? [
                                  BoxShadow(
                                    color: p == 0 ? Colors.red : Colors.blue,
                                    spreadRadius: 0,
                                    blurRadius: 8,
                                  )
                                ]
                              : null,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: (p == 0 ? props.keeperR : props.keeperB) == i
                                ? (p == 0 ? Colors.red : Colors.blue)
                                : Colors.black26,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: props.authers[i]["img"] == null
                                      ? const Icon(Icons.person,
                                          size: 35, color: Colors.black54)
                                      : const ClipRRect(),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      props.authers[i]["name"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 14.5),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      props.authers[i]["id"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            )
        ],
      ),
    );
  }
}
