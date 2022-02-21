import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/login.dart';
import 'package:setes_ctaker/module/api.dart';
import 'package:setes_ctaker/module/simple.dart';
import 'package:setes_ctaker/screen/match.dart';
import 'package:setes_ctaker/screen/matchs.dart';
import 'package:setes_ctaker/screen/profile.dart';

class HomeDrower extends StatelessWidget {
  final Map uData;
  const HomeDrower(this.uData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      width: scr.width * .7,
      height: scr.height,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 200,
            width: scr.width,
            color: Colors.green,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (uData["img"] == null)
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
                        getImgProfile(uData["_id"] + "/" + uData["user_name"]),
                        width: 80,
                        height: 80,
                      ),
                    ),
                  const SizedBox(height: 5),
                  Text(
                    uData["user_name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              const Icon(Icons.home, size: 25),
              SizedBox(
                width: scr.width * .7 - 45,
                child: ListTile(
                  onTap: () => Navigator.pop(context),
                  title: const Text("Home"),
                  subtitle: const Text("Upcoming Match"),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              const Icon(Icons.history, size: 25),
              SizedBox(
                width: scr.width * .7 - 45,
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MatchsScreen())),
                  title: const Text("My Matchs"),
                  subtitle: const Text("Match History"),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              const Icon(Icons.person, size: 25),
              SizedBox(
                width: scr.width * .7 - 45,
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfileScreen(uData),
                    ),
                  ),
                  title: const Text("Profile"),
                  subtitle: const Text("My Profile"),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              const Icon(Icons.person, size: 25),
              SizedBox(
                width: scr.width * .7 - 45,
                child: ListTile(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              'You can login at any time, we will keep all your data safe. thankYou'),
                          actions: [
                            TextButton(
                              onPressed: () => logout(context),
                              child: const Text('Confirm Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: const Text("Logout"),
                  subtitle: const Text("You can login back at any time"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
