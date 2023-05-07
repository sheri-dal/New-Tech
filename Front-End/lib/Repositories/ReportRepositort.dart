import 'package:cancerrapp/Helper/Components/SharePrefrencesKey.dart';
import 'package:cancerrapp/Models/ReportsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Components/Table.dart';
import '../Helper/Database.dart';
import '../Helper/Database/BaseDatabase.dart';

class ReportsRepositort {
  static final dao =
      BaseRepository<ReportModel>(ReportModel(), tableName: Table.reposrt);
  Future<ReportModel> find(int id) => dao.find(id);
  Future<List<ReportModel>> getAll() => dao.getAll();
  Future<int> insert(ReportModel reminder) => dao.insert(reminder);
  Future<void> update(ReportModel reminder) => dao.update(reminder);
  Future<void> delete(ReportModel reminder) => dao.delete(reminder);
  Future<void> deleteById(int id) => dao.deleteById(id);

  Future<List<ReportModel>> getAllByUser() async {
    var db = await DatabaseHelper.instance.database;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt(Prefkey.userId) as int;

    final dbClient = await db;
    var map = await dbClient
        .query(Table.reposrt, where: "userId = ?", whereArgs: [userId]);

    return List.generate(map.length, (i) => ReportModel.fromMap(map[i]));
  }
}
