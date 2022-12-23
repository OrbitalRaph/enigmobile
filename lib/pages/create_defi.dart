import 'package:flutter/material.dart';
import 'package:enigmobile/models/utilisateur.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:enigmobile/components/card_user.dart';
import 'package:enigmobile/models/enigme.dart';
import 'package:enigmobile/models/defi.dart';
import 'package:enigmobile/components/bouton.dart';
import 'package:enigmobile/components/card_enigme.dart';

class CreateDefi extends StatefulWidget {
  const CreateDefi({Key? key}) : super(key: key);

  @override
  _CreateDefiState createState() => _CreateDefiState();
}

class _CreateDefiState extends State<CreateDefi> {
  int currentStep = 0;
  List<Utilisateur> utilisateurs = [];
  List<Enigme> enigmes = [];
  Utilisateur? amiADefier;
  Enigme? enigme;

  Future<void> getUtilisateurs(idUtilisateur) async {
    utilisateurs = await EnigmobileDatabase.utilisateurs();

    // remove the current user from the list
    utilisateurs.removeWhere((element) => element.id == idUtilisateur);
  }

  Future<void> getEnigme() async {
    enigmes = await EnigmobileDatabase.enigmes();
  }

  void creerDefi(int idUtilisateur) async {
    if (amiADefier == null || enigme == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Une erreur est survenue, veuillez réessayer')));
    } else {
      final Defi defi = Defi(
          id: 0,
          enigmeId: enigme!.id,
          utilisateur1Id: amiADefier!.id,
          utilisateur2Id: idUtilisateur,
          score1: 0,
          score2: 0,
          status: 0);

      int idDefi = await EnigmobileDatabase.insertDefi(defi);

      startDefi(defi, idDefi);
    }
  }

  void startDefi(Defi defi, int idDefi) {
    if (idDefi == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Une erreur est survenue lors de la création du défi')));
    } else {
      Navigator.pushNamed(context, '/defi',
          arguments: Defi(
              id: idDefi,
              utilisateur1Id: defi.utilisateur1Id,
              utilisateur2Id: defi.utilisateur2Id,
              enigmeId: defi.enigmeId,
              score1: defi.score1,
              score2: defi.score2,
              status: defi.status));
    }
  }

  @override
  Widget build(BuildContext context) {
    final int idUtilisateur = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        body: Stepper(
            currentStep: currentStep,
            onStepCancel: () {
              setState(() {
                if (currentStep > 0) {
                  currentStep = currentStep - 1;
                } else {
                  currentStep = 0;
                  Navigator.pop(context);
                }
              });
            },
            onStepTapped: (step) {
              if (currentStep > step) {
                setState(() {
                  currentStep = step;
                });
              }
            },
            steps: [
              Step(
                title: const Text('Ami à défier'),
                content: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 600,
                    child: Column(
                      children: [
                        const Text(
                          'Choisissez un ami à défier',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: FutureBuilder(
                            future: getUtilisateurs(idUtilisateur),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.builder(
                                  itemCount: utilisateurs.length,
                                  itemBuilder: (context, index) {
                                    return CardUser(
                                        utilisateur: utilisateurs[index],
                                        onTap: () {
                                          amiADefier = utilisateurs[index];
                                          setState(() {
                                            currentStep = currentStep + 1;
                                          });
                                        });
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    )),
                isActive: currentStep >= 0,
                state: currentStep > 0 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Quiz'),
                content: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 600,
                    child: Column(
                      children: [
                        const Text(
                          'Choisissez une énigme',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: FutureBuilder(
                            future: getEnigme(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.builder(
                                  itemCount: enigmes.length,
                                  itemBuilder: (context, index) {
                                    return CardEnigme(
                                        enigme: enigmes[index],
                                        onTap: () {
                                          enigme = enigmes[index];
                                          setState(() {
                                            currentStep = currentStep + 1;
                                          });
                                        });
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    )),
                isActive: currentStep >= 1,
                state: currentStep > 1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Confirmation'),
                content: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 600,
                    child: Column(children: [
                      const Text(
                        'Confirmez votre choix',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Vous allez défier ${amiADefier?.nom} avec l\'énigme suivante : "${enigme?.titre}"',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://www.woolha.com/media/2020/03/eevee.png'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(enigme?.image ?? ''),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Bouton(
                          text: "Confirmer et faire le quiz",
                          onPressed: () {
                            creerDefi(idUtilisateur);
                          }),
                      const SizedBox(height: 10),
                      const Text(
                        'Attention, si vous quittez et ne remplissez pas le quiz, le défi sera supprimé.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ])),
                isActive: currentStep >= 2,
                state: currentStep > 2 ? StepState.complete : StepState.indexed,
              ),
            ],
            type: StepperType.horizontal,
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Bouton(
                  text: "Revenir à l'arrière", onPressed: details.onStepCancel);
            }));
  }
}
