import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  final Color color;
  final int i;
  final dynamic fun;
  const CounterButton(
      {Key? key, this.color = Colors.black, this.i = 0, this.fun})
      : super(key: key);

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int i = 0;
  @override
  void initState() {
    i = widget.i;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      width: 160,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                i.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() => i++);
              widget.fun(i);
            },
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12)),
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (i != 0) i--;
                widget.fun(i);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12)),
              width: 30,
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: const Icon(Icons.arrow_downward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
