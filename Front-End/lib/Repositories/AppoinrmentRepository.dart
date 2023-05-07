import 'package:cancerrapp/Models/AppoinmentModel.dart';

import '../Helper/Components/Table.dart';
import '../Helper/Database/BaseDatabase.dart';

class AppoinementRepository {
  static final dao = BaseRepository<AppoinmentModel>(AppoinmentModel(),
      tableName: Table.appoinment);
  Future<AppoinmentModel> find(int id) => dao.find(id);
  Future<List<AppoinmentModel>> getAll() => dao.getAll();
  Future<int> insert(AppoinmentModel reminder) => dao.insert(reminder);
  Future<void> update(AppoinmentModel reminder) => dao.update(reminder);
  Future<void> delete(AppoinmentModel reminder) => dao.delete(reminder);
  Future<void> deleteById(int id) => dao.deleteById(id);
}
