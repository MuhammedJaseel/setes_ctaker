import 'package:flutter/material.dart';
import 'package:setes_ctaker/module/simple.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final dynamic ontap;
  const BottomButton(this.title, this.ontap , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: scr.width * .5 - 8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          gradient: LinearGradient(
            colors: [Color(0xffCE5859), Color(0xffEF8464)],
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 30,
              color: Colors.black12,
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
