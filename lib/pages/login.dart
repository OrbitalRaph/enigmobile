import 'package:flutter/material.dart';
import 'package:enigmobile/components/liste_users.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: ListUser(),
          ),
        ));
  }
}
