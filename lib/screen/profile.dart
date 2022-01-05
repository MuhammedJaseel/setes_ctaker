import 'package:flutter/material.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/simple.dart';

class MyProfileScreen extends StatelessWidget {
  final dynamic props;
  const MyProfileScreen(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SizedBox(
        height: scr.height,
        width: scr.width,
        child: Column(
          children: [
            SizedBox(height: scr.height * .06),
            if (props["img"] == null)
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              )
            else
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Image.network(
                  getImgProfile(props["_id"] + "/" + props["user_name"]),
                  width: 80,
                  height: 80,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              props["user_name"],
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
