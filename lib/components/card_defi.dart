import 'package:enigmobile/models/defi.dart';
import 'package:enigmobile/models/enigme.dart';
import 'package:enigmobile/models/utilisateur.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:flutter/material.dart';

class CardDefi extends StatefulWidget {
  const CardDefi({Key? key, required this.defi, this.onTap}) : super(key: key);

  final Defi defi;
  final VoidCallback? onTap;

  @override
  _CardDefiState createState() => _CardDefiState();
}

class _CardDefiState extends State<CardDefi> {
  late Enigme enigme;
  late Utilisateur utilisateur;

  Future<void> getCardData() async {
    utilisateur =
        await EnigmobileDatabase.utilisateur(widget.defi.utilisateur2Id);

    enigme = await EnigmobileDatabase.enigme(widget.defi.enigmeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCardData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(enigme.titre,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Text(
                          "D??fi de ${utilisateur.nom}\na eu un score de ${widget.defi.score2}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
