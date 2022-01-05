import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Loading());
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          SizedBox(child: CircularProgressIndicator(), width: 40, height: 40),
          Padding(padding: EdgeInsets.only(top: 16), child: Text('Loading...'))
        ],
      ),
    );
  }
}

class LoadingSmall extends StatelessWidget {
  const LoadingSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage({Key? key, this.error = "Error"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ErrorBody(error: error));
  }
}

class ErrorBody extends StatelessWidget {
  final String error;
  const ErrorBody({Key? key, this.error = "Error"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
