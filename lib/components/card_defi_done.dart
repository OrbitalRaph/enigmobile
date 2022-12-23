import 'package:enigmobile/models/defi.dart';
import 'package:enigmobile/models/enigme.dart';
import 'package:enigmobile/models/utilisateur.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:flutter/material.dart';

class CardDefiDone extends StatefulWidget {
  const CardDefiDone({Key? key, required this.defi, this.onTap})
      : super(key: key);

  final Defi defi;
  final VoidCallback? onTap;

  @override
  _CardDefiDoneState createState() => _CardDefiDoneState();
}

class _CardDefiDoneState extends State<CardDefiDone> {
  late Enigme enigme;
  late Utilisateur utilisateur1;
  late Utilisateur utilisateur2;

  Future<void> getCardData() async {
    utilisateur2 =
        await EnigmobileDatabase.utilisateur(widget.defi.utilisateur2Id);

    utilisateur1 =
        await EnigmobileDatabase.utilisateur(widget.defi.utilisateur1Id);

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
                color: Colors.grey[300],
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
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${enigme.titre} - Terminé",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false),
                      const SizedBox(height: 10),
                      Text(
                          "${utilisateur2.nom} : ${widget.defi.score2}\n${utilisateur1.nom} : ${widget.defi.score1}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false),
                    ],
                  )),
                  const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
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
