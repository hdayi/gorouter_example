import 'package:flutter/material.dart';
import 'package:gorouter_example/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this._loginOnfo, {super.key});
  final LoginInfo _loginOnfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _loginOnfo.isLoggedIn = true;
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
