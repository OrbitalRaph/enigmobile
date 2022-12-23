class Defi {
  final int id;
  int utilisateur1Id;
  int utilisateur2Id;
  int enigmeId;
  int score1;
  int score2;
  int status;

  Defi(
      {required this.id,
      required this.utilisateur1Id,
      required this.utilisateur2Id,
      required this.enigmeId,
      required this.score1,
      required this.score2,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'utilisateur1_id': utilisateur1Id,
      'utilisateur2_id': utilisateur2Id,
      'enigme_id': enigmeId,
      'score1': score1,
      'score2': score2,
      'status': status,
    };
  }
}
