import 'package:flutter/material.dart';
import 'package:setes_ctaker/method/login.dart';
import 'package:setes_ctaker/module/simple.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController userNameC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset("asset/aqai_logo.png", width: scr.width * .4),
            // SizedBox(height: scr.height * .03),
            const Text(
              'Setes Caretaker',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  letterSpacing: .2,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              'Caretaker Log in Form',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                  letterSpacing: .2,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: scr.height * .05),
            TextField(
              controller: userNameC,
              autocorrect: true,
              decoration: const InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.phone, color: Colors.black54),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                hintStyle: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: Color.fromARGB(10, 255, 255, 255),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.black12, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
            ),
            SizedBox(height: scr.height * .02),
            TextField(
              controller: passwordC,
              autocorrect: true,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.password, color: Colors.black54),
                // suffixIcon: sufficIcon,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                hintStyle: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: Color.fromARGB(10, 255, 255, 255),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.black12, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
            ),
            SizedBox(height: scr.height * .03),
            const Text(
              'In case of any failer on login contact your admin, admin can only possible to update a care taker',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15,
                  letterSpacing: .2,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: scr.height * .03),
            LoginLogin(this)
          ],
        ),
      ),
    );
  }
}

class LoginLogin extends StatefulWidget {
  final props;
  const LoginLogin(this.props, {Key? key}) : super(key: key);

  @override
  _LoginLoginState createState() => _LoginLoginState();
}

class _LoginLoginState extends State<LoginLogin> {
  String? error;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: [
        Center(
            child: Text(error ?? "", style: TextStyle(color: Colors.red[400]))),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: scr.width,
          height: 50,
          child: ElevatedButton(
            child: Text(
              loading ? 'Loading..' : "Log in",
              style: const TextStyle(
                  fontSize: 18, letterSpacing: .2, fontWeight: FontWeight.w500),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              backgroundColor: MaterialStateProperty.all(
                loading ? Colors.black26 : const Color(0xffA4CD38),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () => login(this),
          ),
        ),
      ],
    );
  }
}
