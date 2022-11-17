import 'package:flutter/material.dart';
import 'bouton.dart';
import 'card_defi.dart';

// list of item in a rounded rectangle
class ListeDefis extends StatelessWidget {
  const ListeDefis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),

        // title of the list and then the list
        child: Column(
          children: [
            const Text(
              'Défis à complété',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardDefi();
                },
              ),
            ),

            // button to add a new challenge
            Bouton(text: "Défier un ami", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
