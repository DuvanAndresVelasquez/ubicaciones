import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  ///Definición de la base de datos
  ///La llamaremos app_database.db
  ///creamos 3 tablas: locations, friends, friend_location
  Future<void> _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        latitud REAL NOT NULL,
        longitud REAL NOT NULL,
        description TEXT,
        photos TEXT, -- We will save the photos as a serializable JSON list.
        UNIQUE(latitud, longitud)
      )
    ''');

    await db.execute('''
      CREATE TABLE friends (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT NOT NULL,
        photo TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE friend_location (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        friend_id INTEGER NOT NULL,
        location_id INTEGER NOT NULL,
        FOREIGN KEY (friend_id) REFERENCES friends (id),
        FOREIGN KEY (location_id) REFERENCES locations (id),
        UNIQUE (friend_id, location_id)
      )
    ''');

  }
}
