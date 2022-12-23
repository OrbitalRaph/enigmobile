import 'package:enigmobile/models/enigme.dart';
import 'package:flutter/material.dart';

class CardEnigme extends StatelessWidget {
  final Enigme enigme;
  final VoidCallback? onTap;

  const CardEnigme({Key? key, required this.enigme, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(enigme.image),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(enigme.titre,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.fade,
                  softWrap: false),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
