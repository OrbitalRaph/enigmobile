import 'package:flutter/material.dart';
import 'package:enigmobile/models/defi.dart';
import 'package:enigmobile/models/question.dart';
import 'package:enigmobile/models/choix.dart';
import 'package:enigmobile/database/enigmobile_database.dart';
import 'package:enigmobile/components/bouton.dart';

class DefiForm extends StatefulWidget {
  const DefiForm({Key? key}) : super(key: key);

  @override
  _DefiFormState createState() => _DefiFormState();
}

class _DefiFormState extends State<DefiForm> {
  late List<Question> questions;
  late Defi defi;
  int currentQuestion = 0;
  int score = 0;

  Future<void> getDefiData(int enigmeId) async {
    questions = await EnigmobileDatabase.questions(enigmeId);
  }

  void submitQuiz(Defi defi) {
    Defi updatedDefi = defi;

    if (updatedDefi.status == 0) {
      updatedDefi.status = 1;
      updatedDefi.score2 = score;
    } else if (updatedDefi.status == 1) {
      updatedDefi.status = 2;
      updatedDefi.score1 = score;
    }

    EnigmobileDatabase.updateDefi(updatedDefi);
    popUp();
  }

  popUp() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: const Text('Terminé !'),
                content: Text(defi.status == 1
                    ? 'Vous avez eu un score de $score/${questions.length} !'
                    : 'Votre score est de $score/${questions.length}, celui de votre adversaire est de ${defi.score2}/${questions.length}.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
        });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Êtes-vous sûr de vouloir quitter ?'),
            content: Text(defi.status < 1
                ? 'Si vous quittez, le défi sera supprimé.'
                : 'Vous pourrez reprendre le défi plus tard.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: () => {
                  if (defi.status < 1) EnigmobileDatabase.deleteDefi(defi.id),
                  Navigator.popUntil(context, ModalRoute.withName('/home')),
                },
                child: const Text('Oui'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    defi = ModalRoute.of(context)!.settings.arguments as Defi;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: FutureBuilder(
            future: getDefiData(defi.enigmeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  questions.isNotEmpty) {
                return Stepper(
                  currentStep: currentQuestion,
                  type: StepperType.horizontal,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return const SizedBox.shrink();
                  },
                  steps: List.generate(questions.length, (index) {
                    return Step(
                      title: const Text(''),
                      content: FutureBuilder(
                        future: EnigmobileDatabase.choix(questions[index].id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<Choix> choix = snapshot.data as List<Choix>;
                            return Column(children: [
                              const SizedBox(height: 20),
                              Text(
                                questions[index].question,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: List.generate(choix.length, (index) {
                                  return Bouton(
                                    text: choix[index].choix,
                                    onPressed: () {
                                      if (choix[index].bonneReponse == 1) {
                                        setState(() {
                                          score++;
                                        });
                                      }
                                      if (currentQuestion <
                                          questions.length - 1) {
                                        setState(() {
                                          currentQuestion++;
                                        });
                                      } else {
                                        submitQuiz(defi);
                                      }
                                    },
                                  );
                                }),
                              )
                            ]);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                      isActive: currentQuestion >= index,
                      state: currentQuestion > index
                          ? StepState.complete
                          : StepState.indexed,
                    );
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
