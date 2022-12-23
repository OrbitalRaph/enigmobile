class Utilisateur {
  int id;
  String nom;

  Utilisateur({required this.id, required this.nom});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
  }
}
