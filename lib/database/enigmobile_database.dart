import 'dart:async';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:enigmobile/models/utilisateur.dart';
import 'package:enigmobile/models/enigme.dart';
import 'package:enigmobile/models/defi.dart';
import 'package:enigmobile/models/question.dart';
import 'package:enigmobile/models/choix.dart';

class EnigmobileDatabase {
  static Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'enigmobile_database.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE utilisateur(id INTEGER PRIMARY KEY, nom TEXT);");
        db.execute(
            "CREATE TABLE enigme(id INTEGER PRIMARY KEY, titre TEXT, image TEXT);");
        db.execute(
            "CREATE TABLE defi(id INTEGER PRIMARY KEY, utilisateur1_id INTEGER, utilisateur2_id INTEGER, enigme_id INTEGER, score1 INTEGER, score2 INTEGER, status INTEGER, FOREIGN KEY(utilisateur1_id) REFERENCES utilisateur(id), FOREIGN KEY(utilisateur2_id) REFERENCES utilisateur(id), FOREIGN KEY(enigme_id) REFERENCES enigme(id));");
        db.execute(
            "CREATE TABLE question(id INTEGER PRIMARY KEY, enigme_id INTEGER, question TEXT, FOREIGN KEY(enigme_id) REFERENCES enigme(id));");
        db.execute(
            "CREATE TABLE choix(id INTEGER PRIMARY KEY, question_id INTEGER, choix TEXT, bonne_reponse INTEGER, FOREIGN KEY(question_id) REFERENCES question(id))");

        db.insert('utilisateur', {'id': 1, 'nom': 'Raph'});
        db.insert('utilisateur', {'id': 2, 'nom': 'Willy'});
        db.insert('utilisateur', {'id': 3, 'nom': 'Maxi'});
        db.insert('utilisateur', {'id': 4, 'nom': 'Gaby'});

        db.insert('enigme',
            {'id': 1, 'titre': 'Enigme facile', 'image': 'assets/toucan.png'});
        db.insert('enigme', {
          'id': 2,
          'titre': 'Enigme intermédiaire',
          'image': 'assets/girafe.png'
        });
        db.insert('enigme',
            {'id': 3, 'titre': 'Enigme expert', 'image': 'assets/lion.png'});

        db.insert('question',
            {'id': 1, 'enigme_id': 1, 'question': 'Quel est un Toucan ?'});
        db.insert('question', {
          'id': 2,
          'enigme_id': 1,
          'question': 'De quelles couleurs est un Toucan ?'
        });
        db.insert('question',
            {'id': 3, 'enigme_id': 1, 'question': 'Où vit un Toucan ?'});
        db.insert('question', {
          'id': 4,
          'enigme_id': 2,
          'question': 'Comment dit-on girafe en anglais ?'
        });
        db.insert('question', {
          'id': 5,
          'enigme_id': 2,
          'question': 'La girafe est-elle un mammifère ?'
        });
        db.insert('question', {
          'id': 6,
          'enigme_id': 2,
          'question': 'La girafe est-elle un oiseau ?'
        });
        db.insert('question', {
          'id': 7,
          'enigme_id': 3,
          'question': 'Les lions sont de la famille des...'
        });
        db.insert('question',
            {'id': 8, 'enigme_id': 3, 'question': 'Les lions vivent en...'});
        db.insert('question', {
          'id': 9,
          'enigme_id': 3,
          'question': 'Qui est le roi des animaux ?'
        });

        db.insert('choix', {
          'id': 1,
          'question_id': 1,
          'choix': 'Un mammifère marin',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 2,
          'question_id': 1,
          'choix': 'Un oiseau',
          'bonne_reponse': 1
        });
        db.insert('choix', {
          'id': 3,
          'question_id': 1,
          'choix': 'Un reptile',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 4,
          'question_id': 1,
          'choix': 'Un insecte',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 5,
          'question_id': 2,
          'choix': 'Magenta',
          'bonne_reponse': 0
        });
        db.insert('choix',
            {'id': 6, 'question_id': 2, 'choix': 'Indigo', 'bonne_reponse': 0});
        db.insert('choix', {
          'id': 7,
          'question_id': 2,
          'choix': 'Écarlate',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 8,
          'question_id': 2,
          'choix': 'De plusieurs couleurs',
          'bonne_reponse': 1
        });
        db.insert('choix', {
          'id': 9,
          'question_id': 3,
          'choix': 'En Amérique du Sud',
          'bonne_reponse': 1
        });
        db.insert('choix', {
          'id': 10,
          'question_id': 3,
          'choix': 'En Afrique',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 11,
          'question_id': 3,
          'choix': 'En Asie',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 12,
          'question_id': 3,
          'choix': 'En Europe',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 13,
          'question_id': 4,
          'choix': 'Jiraffe',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 14,
          'question_id': 4,
          'choix': 'Giraffe',
          'bonne_reponse': 1
        });
        db.insert('choix', {
          'id': 15,
          'question_id': 4,
          'choix': 'Girafe',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 16,
          'question_id': 4,
          'choix': 'Girafee',
          'bonne_reponse': 0
        });
        db.insert('choix',
            {'id': 29, 'question_id': 5, 'choix': 'Oui', 'bonne_reponse': 1});
        db.insert('choix',
            {'id': 30, 'question_id': 5, 'choix': 'Non', 'bonne_reponse': 0});
        db.insert('choix',
            {'id': 33, 'question_id': 6, 'choix': 'Oui', 'bonne_reponse': 0});
        db.insert('choix',
            {'id': 34, 'question_id': 6, 'choix': 'Non', 'bonne_reponse': 1});
        db.insert('choix',
            {'id': 17, 'question_id': 7, 'choix': 'Chat', 'bonne_reponse': 0});
        db.insert('choix',
            {'id': 18, 'question_id': 7, 'choix': 'Félin', 'bonne_reponse': 0});
        db.insert('choix', {
          'id': 19,
          'question_id': 7,
          'choix': 'Félix Michaud',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 20,
          'question_id': 7,
          'choix': 'Felidae',
          'bonne_reponse': 1
        });
        db.insert('choix',
            {'id': 21, 'question_id': 8, 'choix': 'Meute', 'bonne_reponse': 1});
        db.insert('choix', {
          'id': 22,
          'question_id': 8,
          'choix': 'Solitaire',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 23,
          'question_id': 8,
          'choix': 'Groupe',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 24,
          'question_id': 8,
          'choix': 'Grappe',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 25,
          'question_id': 9,
          'choix': 'Les toucans',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 26,
          'question_id': 9,
          'choix': 'Les girafes',
          'bonne_reponse': 0
        });
        db.insert('choix', {
          'id': 27,
          'question_id': 9,
          'choix': 'Les lions',
          'bonne_reponse': 1
        });
        db.insert('choix', {
          'id': 28,
          'question_id': 9,
          'choix': 'Les éléphants',
          'bonne_reponse': 0
        });

        db.insert('defi', {
          'id': 1,
          'utilisateur1_id': 1,
          'utilisateur2_id': 2,
          'enigme_id': 1,
          'score1': 2,
          'score2': 3,
          'status': 2
        });

        db.insert('defi', {
          'id': 2,
          'utilisateur1_id': 1,
          'utilisateur2_id': 3,
          'enigme_id': 2,
          'score1': 0,
          'score2': 0,
          'status': 1
        });

        db.insert('defi', {
          'id': 3,
          'utilisateur1_id': 1,
          'utilisateur2_id': 4,
          'enigme_id': 3,
          'score1': 0,
          'score2': 0,
          'status': 1
        });

        db.insert('defi', {
          'id': 4,
          'utilisateur1_id': 2,
          'utilisateur2_id': 3,
          'enigme_id': 1,
          'score1': 0,
          'score2': 0,
          'status': 1
        });

        db.insert('defi', {
          'id': 5,
          'utilisateur1_id': 2,
          'utilisateur2_id': 4,
          'enigme_id': 2,
          'score1': 0,
          'score2': 0,
          'status': 1
        });

        db.insert('defi', {
          'id': 6,
          'utilisateur1_id': 3,
          'utilisateur2_id': 4,
          'enigme_id': 3,
          'score1': 0,
          'score2': 0,
          'status': 1
        });

        db.insert('defi', {
          'id': 7,
          'utilisateur1_id': 2,
          'utilisateur2_id': 1,
          'enigme_id': 1,
          'score1': 0,
          'score2': 0,
          'status': 1
        });

        db.insert('defi', {
          'id': 8,
          'utilisateur1_id': 3,
          'utilisateur2_id': 1,
          'enigme_id': 2,
          'score1': 0,
          'score2': 0,
          'status': 1
        });
      },
      version: 1,
    );
    return database;
  }

  static Future<void> insertUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;

    Map<String, dynamic> utilisateurMap = utilisateur.toMap();
    utilisateurMap.remove('id');

    await db.insert(
      'utilisateur',
      utilisateurMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertDefi(Defi defi) async {
    final Database db = await database;

    Map<String, dynamic> defiMap = defi.toMap();
    defiMap.remove('id');

    final int instertedId = await db.insert(
      'defi',
      defiMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return instertedId;
  }

  static Future<List<Utilisateur>> utilisateurs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('utilisateur');
    List<Utilisateur> utilisateurs = [];

    for (Map map in maps) {
      utilisateurs.add(Utilisateur(id: map['id'], nom: map['nom']));
    }

    return utilisateurs;
  }

  static Future<List<Enigme>> enigmes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('enigme');
    List<Enigme> enigmes = [];

    for (Map map in maps) {
      enigmes
          .add(Enigme(id: map['id'], titre: map['titre'], image: map['image']));
    }

    return enigmes;
  }

  // get defis by utilisateur id
  static Future<List<Defi>> defis(int utilisateurId) async {
    final Database db = await database;

    // get defis where utilisateur1_id = utilisateurId, status > 0 and order by status asc
    final List<Map<String, dynamic>> maps = await db.query('defi',
        where: 'utilisateur1_id = ? AND status > 0',
        whereArgs: [utilisateurId],
        orderBy: 'status ASC');
    List<Defi> defis = [];

    for (Map map in maps) {
      defis.add(Defi(
          id: map['id'],
          utilisateur1Id: map['utilisateur1_id'],
          utilisateur2Id: map['utilisateur2_id'],
          enigmeId: map['enigme_id'],
          score1: map['score1'],
          score2: map['score2'],
          status: map['status']));
    }

    return defis;
  }

  // get question by enigme id
  static Future<List<Question>> questions(int enigmeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('question', where: 'enigme_id = ?', whereArgs: [enigmeId]);
    List<Question> questions = [];

    for (Map map in maps) {
      questions.add(Question(
          id: map['id'],
          enigmeId: map['enigme_id'],
          question: map['question']));
    }
    return questions;
  }

  // get choix by question id
  static Future<List<Choix>> choix(int questionId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('choix', where: 'question_id = ?', whereArgs: [questionId]);
    List<Choix> choix = [];

    for (Map map in maps) {
      choix.add(Choix(
          id: map['id'],
          questionId: map['question_id'],
          choix: map['choix'],
          bonneReponse: map['bonne_reponse']));
    }
    return choix;
  }

  // get enigme by id
  static Future<Enigme> enigme(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('enigme', where: 'id = ?', whereArgs: [id]);

    return Enigme(
        id: maps[0]['id'], titre: maps[0]['titre'], image: maps[0]['image']);
  }

  // get utilisateur by id
  static Future<Utilisateur> utilisateur(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('utilisateur', where: 'id = ?', whereArgs: [id]);

    return Utilisateur(id: maps[0]['id'], nom: maps[0]['nom']);
  }

  static Future<void> updateUtilisateur(Utilisateur utilisateur) async {
    final db = await database;
    await db.update(
      'utilisateur',
      utilisateur.toMap(),
      where: "id = ?",
      whereArgs: [utilisateur.id],
    );
  }

  static Future<void> updateEnigme(Enigme enigme) async {
    final db = await database;
    await db.update(
      'enigme',
      enigme.toMap(),
      where: "id = ?",
      whereArgs: [enigme.id],
    );
  }

  static Future<void> updateDefi(Defi defi) async {
    final db = await database;
    await db.update(
      'defi',
      defi.toMap(),
      where: "id = ?",
      whereArgs: [defi.id],
    );
  }

  static Future<void> updateQuestion(Question question) async {
    final db = await database;
    await db.update(
      'question',
      question.toMap(),
      where: "id = ?",
      whereArgs: [question.id],
    );
  }

  static Future<void> updateChoix(Choix choix) async {
    final db = await database;
    await db.update(
      'choix',
      choix.toMap(),
      where: "id = ?",
      whereArgs: [choix.id],
    );
  }

  static Future<void> deleteUtilisateur(int id) async {
    final db = await database;
    await db.delete(
      'utilisateur',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteEnigme(int id) async {
    final db = await database;
    await db.delete(
      'enigme',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteDefi(int id) async {
    final db = await database;
    await db.delete(
      'defi',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteQuestion(int id) async {
    final db = await database;
    await db.delete(
      'question',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteChoix(int id) async {
    final db = await database;
    await db.delete(
      'choix',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
