import 'package:flutter/material.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:enigmobile/models/defi.dart';
import 'bouton.dart';
import 'card_defi.dart';
import 'card_defi_done.dart';

class ListDefi extends StatefulWidget {
  final int idUtilisateur;
  const ListDefi({Key? key, required this.idUtilisateur}) : super(key: key);

  @override
  _ListDefiState createState() => _ListDefiState();
}

class _ListDefiState extends State<ListDefi> {
  List<Defi> defis = [];

  Future<void> getDefis() async {
    defis = await EnigmobileDatabase.defis(widget.idUtilisateur);
  }

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
        child: Column(
          children: [
            const Text(
              'Vos défis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: getDefis(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: defis.length,
                      itemBuilder: (context, index) {
                        if (defis[index].status == 1) {
                          return CardDefi(
                              defi: defis[index],
                              onTap: () {
                                Navigator.pushNamed(context, '/defi',
                                        arguments: defis[index])
                                    .then((value) => {setState(() {})});
                              });
                        } else if (defis[index].status == 2) {
                          return CardDefiDone(
                              defi: defis[index],
                              onTap: () {
                                setState(() {
                                  EnigmobileDatabase.deleteDefi(
                                      defis[index].id);
                                  defis.removeWhere(
                                      (defi) => defi.id == defis[index].id);
                                });
                              });
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Bouton(
                text: "Défier un ami",
                onPressed: () {
                  Navigator.pushNamed(context, '/create_defi',
                      arguments: widget.idUtilisateur);
                }),
          ],
        ),
      ),
    );
  }
}
