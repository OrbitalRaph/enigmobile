class Enigme {
  final int id;
  final String titre;
  final String image;

  Enigme({required this.id, required this.titre, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'image': image,
    };
  }
}
