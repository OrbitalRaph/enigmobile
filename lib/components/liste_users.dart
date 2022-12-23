import 'package:enigmobile/components/card_user.dart';
import 'package:enigmobile/components/creer_utilisateur.dart';
import 'package:enigmobile/models/utilisateur.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<Utilisateur> utilisateurs = [];

  Future<void> getUtilisateurs() async {
    utilisateurs = await EnigmobileDatabase.utilisateurs();
  }

  // add a new user to the list
  void _addUtilisateur(Utilisateur utilisateur) {
    setState(() {
      utilisateurs.add(utilisateur);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'Utilisateurs',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'Choisissez un utilisateur',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: FutureBuilder(
            future: getUtilisateurs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: utilisateurs.length,
                  itemBuilder: (context, index) {
                    return CardUser(utilisateur: utilisateurs[index]);
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
        const SizedBox(height: 15),
        CreerUtilisateur(addUtilisateur: _addUtilisateur),
      ],
    );
  }
}
