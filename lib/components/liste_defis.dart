import 'package:flutter/material.dart';

// list of item in a rounded rectangle
class ListeDefis extends StatelessWidget {
  const ListeDefis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
