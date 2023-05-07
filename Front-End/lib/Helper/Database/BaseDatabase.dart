import 'package:sqflite/sqflite.dart';

import '../Database.dart';

class BaseRepository<T extends BaseModel> {
  Future<Database> get db => DatabaseHelper.instance.database;
  final String tableName;
  final BaseModel instance;

  BaseRepository(this.instance, {required this.tableName});

  BaseModel fromJson(dynamic map) => instance.fromJson(map);

  Future<T> find(int id) async {
    final dbClient = await db;
    var map = await dbClient.query(tableName, where: "id = ?", whereArgs: [id]);
    return fromJson(map.first) as T;
  }

  Future<List<T>> getAll() async {
    var dbClient = await db;
    var map = await dbClient.query(tableName);
    return List.generate(map.length, (i) => fromJson(map[i]) as T);
  }

  Future<int> insert(BaseModel model) async {
    var dbClient = await db;
    return await dbClient.insert(tableName, model.toJson());
  }

  Future<void> update(BaseModel model) async {
    final dbClient = await db;
    await dbClient.update(
      tableName,
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  Future<void> delete(BaseModel model) async {
    final dbClient = await db;
    await dbClient.delete(tableName, where: "id = ?", whereArgs: [model.id]);
  }

  Future<void> deleteById(int id) async {
    final dbClient = await db;
    await dbClient.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}

abstract class BaseModel<Tkey> {
  Tkey? id;
  Map<String, dynamic> toJson();
  BaseModel fromJson(Map<String, dynamic> json);
}
