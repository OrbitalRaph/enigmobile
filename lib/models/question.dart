class Question {
  final int id;
  final int enigmeId;
  final String question;

  Question({required this.id, required this.enigmeId, required this.question});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enigme_id': enigmeId,
      'question': question,
    };
  }
}
