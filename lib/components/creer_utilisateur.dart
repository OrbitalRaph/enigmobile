import 'package:enigmobile/components/bouton.dart';
import 'package:enigmobile/models/utilisateur.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:flutter/material.dart';

class CreerUtilisateur extends StatefulWidget {
  final Function addUtilisateur;

  const CreerUtilisateur({Key? key, required this.addUtilisateur})
      : super(key: key);

  @override
  _CreerUtilisateurState createState() => _CreerUtilisateurState();
}

class _CreerUtilisateurState extends State<CreerUtilisateur> {
  final _formKey = GlobalKey<FormState>();
  final _utilisateurController = TextEditingController();

  // function to create a new user when the button is pressed
  void _creerUtilisateur() {
    if (_formKey.currentState!.validate()) {
      final utilisateur = Utilisateur(id: 0, nom: _utilisateurController.text);
      EnigmobileDatabase.insertUtilisateur(utilisateur);
      FocusScope.of(context).unfocus();
      _utilisateurController.clear();
      widget.addUtilisateur(utilisateur);
    }
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
              'Créer un utilisateur',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: TextFormField(
            autofocus: false,
            controller: _utilisateurController,
            decoration: const InputDecoration(
              labelText: 'Nom d\'utilisateur',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom';
              }
              return null;
            },
          ),
        ),
        Bouton(text: 'Nouveau utilisateur', onPressed: _creerUtilisateur)
      ],
    );
  }
}
