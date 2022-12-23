import 'package:enigmobile/models/utilisateur.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';

// item card
class CardUser extends StatelessWidget {
  final Utilisateur utilisateur;
  final VoidCallback? onTap;

  const CardUser({Key? key, required this.utilisateur, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(context, '/home', arguments: utilisateur);
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
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://www.woolha.com/media/2020/03/eevee.png'),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(utilisateur.nom,
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
