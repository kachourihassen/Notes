import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/model/note.dart';

/*
la classe NoteRepository encapsule la logique d'accès à la base de données SQLite pour les opérations d'insertion et de récupération des notes. 
Elle assure également l'initialisation de la base de données lors de la première utilisation. 
Cette classe est utilisée par le BLoC NoteBloc pour gérer les données de l'application.
 */
class NoteRepository {
  static Database? _database;
  final String tableName = 'notes';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(tableName, note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }
}
