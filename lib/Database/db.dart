import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:smiley/Model/joke_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  static Database? _database;
  static final DB db = DB._();

  DB._();


  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Joke table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'jokeDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Joke('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'jokeID INTEGER,'
              'joke TEXT,'
              'likeCount INTEGER'
              ')');
        });
  }

  // Insert Joke on database
  addJoke(Joke newJoke) async {
    // await deleteAllJokes();

    final db = await database;
    final res1 = await db?.rawQuery("SELECT id,jokeID,likeCount FROM Joke WHERE jokeID==${newJoke.jokeID}");
    if(res1!.isEmpty) {
      newJoke.likeCount = 1;
      final res = await db?.insert('Joke', newJoke.toJson());
    }
    else{
      newJoke.likeCount = res1[0]['likeCount']==0?1:0;
      deleteJoke(newJoke);
    }
    return;
  }

  updateJoke(Joke newJoke)async{
    final db = await database;

    db?.rawUpdate("UPDATE Joke "
        "SET likeCount = ${newJoke.likeCount} "
        "WHERE jokeID = ${newJoke.jokeID}");
    return;
  }

  deleteJoke(Joke newJoke)async{
    final db = await database;

    db?.rawDelete("DELETE FROM Joke "
        "WHERE jokeID = ${newJoke.jokeID}");
    return;
  }
  // Delete all Jokes
  Future<int?> deleteAllJokes() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM Joke');
    return res;
  }

  Future<JokeModel> getAllJokes() async {
    final db = await database;
    final res = await db?.rawQuery("SELECT * FROM Joke");
    List<Joke> list =
    res!.isNotEmpty ? res.map((c) => Joke.fromJson(c)).toList() : [];
    JokeModel jokeModel = JokeModel(
      amount: list.length,
      jokes: list,
    );
    return jokeModel;
  }

}