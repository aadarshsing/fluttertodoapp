import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/data_model.dart';

class DatabaseHelper {
  static const String _dbName = 'Notes.db';
  static const int _version = 1;

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      return await db.execute(
          "CREATE TABLE Note(id INTEGER PRIMARY KEY ,dateTime TEXT NOT NULL,title TEXT NOT NULL,description TEXT NOT NULL);");
    }, version: _version);
  }

  static Future<int> insertNote(NoteData note) async {
    print('note inserted');
    final db = await _getDB();
    return await db.insert('Note', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(NoteData note) async {
    print('note updated');
    final db = await _getDB();
    return await db.update('Note', note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteNote(NoteData note) async {
    final db = await _getDB();
    await db.delete('Note', where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<NoteData>?> getAllNote() async {
    final db = await _getDB();
    print('get all note called');
    final List<Map<String, dynamic>> map = await db.query('Note');
    if (map.isEmpty) {
      return null;
    } else {
      return  List.generate(
          map.length,
          (i)  => NoteData(
              id: map[i]['id'],
              dateTime: map[i]['dateTime'] as String,
              title: map[i]['title'] as String,
              description: map[i]['description'] as String));
    }
  }
}
