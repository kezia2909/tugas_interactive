import 'package:flutter_application_1/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "my_db.sqlite");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nilai DOUBLE, grade VARCHAR(2))',
      );
    });
  }

  Future insertNotes(NotesModel notes) async {
    final db = await database;
    await db.insert('notes', notes.toMap());
  }

  Future getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query('notes');
    return List.generate(data.length, (index) {
      print("DATA : $data");
      return NotesModel(
        id: data[index]['id'],
        nilai: data[index]['nilai'],
        grade: data[index]['grade'],
      );
    });
  }
}
