import 'package:cancerrapp/Helper/Database.dart';
import 'package:cancerrapp/Helper/Database/BaseDatabase.dart';

import '../Helper/Components/Table.dart';
import '../Models/UserModel.dart';

class UserRepository {
  static final dao =
      BaseRepository<UserModel>(UserModel(), tableName: Table.users);
  Future<UserModel> find(int id) => dao.find(id);
  Future<List<UserModel>> getAll() => dao.getAll();
  Future<int> insert(UserModel reminder) => dao.insert(reminder);
  Future<void> update(UserModel reminder) => dao.update(reminder);
  Future<void> delete(UserModel reminder) => dao.delete(reminder);
  Future<void> deleteById(int id) => dao.deleteById(id);

  static Future<UserModel?> getUser(String userName) async {
    var db = await DatabaseHelper.instance.database;
    var map = await db
        .rawQuery("select * from ${Table.users} where userName = '$userName' ");
    if (map.length > 0) {
      var model = UserModel.fromMap(map[0]);
      return model;
    }
    return null;
  }

  static Future<UserModel?> LogIn(String userName, String password) async {
    var db = await DatabaseHelper.instance.database;
    var map = await db.rawQuery(
        "select * from ${Table.users} where userName = '$userName' and password = '$password' ");
    if (map.length > 0) {
      var model = UserModel.fromMap(map[0]);
      return model;
    }
    return null;
  }
}
