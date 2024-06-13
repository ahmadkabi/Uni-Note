import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entity/note_entity.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'note_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
        );
      },
    );
  }

  // A method that retrieves all the notes from the notes table.
  Future<List<NoteEntity>> getNotes() async {
    final db = await database;
    final List<Map<String, Object?>> noteMaps = await db.query('notes');

    return [
      for (final {
      'id': id as int,
      'title': title as String,
      'content': content as String?,
      } in noteMaps)
        NoteEntity(id: id, title: title, content: content),
    ];
  }

  Future<NoteEntity?> getNoteById(int id) async {
    final db = await database;
    final List<Map<String, Object?>> noteMaps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (noteMaps.isNotEmpty) {
      final noteMap = noteMaps.first;
      return NoteEntity(
        id: noteMap['id'] as int,
        title: noteMap['title'] as String,
        content: noteMap['content'] as String?,
      );
    } else {
      return null;
    }
  }

  Future<void> insertNote(NoteEntity note) async {
    final db = await database;

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertNotes(List<NoteEntity> notes) async {
    final db = await database;

    await db.transaction((transaction) async {
      for (NoteEntity note in notes) {
        await transaction.insert(
          'notes',
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> updateNote(NoteEntity note) async {
    final db = await database;

    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;

    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
