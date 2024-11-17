import 'dart:convert';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fulltimeforce_test/app/_shared/pokemon/domain/entities/pokemon.dart';

class SQLiteHelper {
  static const String _tableName = 'pokemons';
  static const String _columnId = 'id';
  static const String _columnData = 'data';

  static final SQLiteHelper _instance = SQLiteHelper._internal();
  SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'test.db');

    final parentDir = Directory(dbPath);
    if (!await parentDir.exists()) {
      await parentDir.create(recursive: true);
    }

    final dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY,
            $_columnData TEXT
          )
        ''');
      },
    );

    return dataBase;
  }

  Future<List<Pokemon>> getPokemons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    List<Pokemon> result = [];

    for (var map in maps) {
      Map<String, dynamic> chunk = jsonDecode(map['data']);
      result.add(Pokemon.fromJson(chunk));
    }

    return result;
  }

  Future<int> insertPokemon(Pokemon pokemon) async {
    final db = await database;
    return await db.insert(
      _tableName,
      {
        _columnId: pokemon.id,
        _columnData: jsonEncode(pokemon.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deletePokemon(Pokemon pokemon) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [pokemon.id],
    );
  }
}
