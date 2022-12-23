class Choix {
  final int id;
  final int questionId;
  final String choix;
  final int bonneReponse;

  Choix(
      {required this.id,
      required this.questionId,
      required this.choix,
      required this.bonneReponse});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question_id': questionId,
      'choix': choix,
      'bonne_reponse': bonneReponse,
    };
  }
}
