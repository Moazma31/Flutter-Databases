
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import '../models/note.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;

      _db = await openDatabase(
        'notes_app.db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE notes(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              content TEXT NOT NULL,
              created_at TEXT NOT NULL
            )
          ''');
        },
      );
    } else {
      _db = await _initDb();
    }

    return _db!;
  }

  Future<Database> _initDb() async {
    final folder = await getDatabasesPath();
    final path = join(folder, 'notes_app.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertNote(Note note) async {
    final db = await database;

    return db.insert(
      'notes',
      note.toMap()..remove('id'),
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;

    final rows = await db.query(
      'notes',
      orderBy: 'created_at DESC',
    );

    return rows.map(Note.fromMap).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await database;

    return db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;

    return db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
