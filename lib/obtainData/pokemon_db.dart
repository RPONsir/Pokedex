import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FavouritePokemon {
  final int pokemonId;
  final String pokemonName;

  FavouritePokemon({
    required this.pokemonId,
    required this.pokemonName,
  });

  factory FavouritePokemon.fromMap(Map<String, dynamic> json) =>
      FavouritePokemon(
        pokemonId: json['pokemonId'],
        pokemonName: json['pokemonName'],
      );

  Map<String, dynamic> toMap() {
    return {
      'pokemonId': pokemonId,
      'pokemonName': pokemonName,
    };
  }
}

class DataBaseHelper {
  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favouritePokemon.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favouritePokemon(
        pokemonId INTEGER PRIMARY KEY,
        pokemonName TEXT
      )
      ''');
  }

  Future<List<Map<String, Object?>>> getFavouritePokemon() async {
    Database db = await instance.database;
    var favouritePokemon =
        await db.query('favouritePokemon', orderBy: 'pokemonId');
    /*List<FavouritePokemon> favouritePokemonList = favouritePokemon.isNotEmpty
    ? favouritePokemon.map((c) => FavouritePokemon.fromMap(c)).toList()
    : [];*/
    return favouritePokemon;
  }

  Future<int> add(FavouritePokemon favouritePokemon) async {
    Database db = await instance.database;
    return await db.insert(
      'favouritePokemon',
      favouritePokemon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> remove(int pokemonId) async {
    Database db = await instance.database;
    return await db.delete('favouritePokemon',
        where: 'pokemonId=?', whereArgs: [pokemonId]);
  }

  Future<int> update(FavouritePokemon favouritePokemon) async {
    Database db = await instance.database;
    return await db.update('favouritePokemon', favouritePokemon.toMap(),
        where: 'pokemonId=?', whereArgs: [favouritePokemon.pokemonId]);
  }
}
