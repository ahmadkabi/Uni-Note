import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'note_entity.dart';

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
  Future<List<NoteEntity>> notes() async {
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


  // Define a function that inserts notes into the database
  Future<void> insertNote(NoteEntity note) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Note into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same note is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
