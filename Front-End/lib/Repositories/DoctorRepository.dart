import 'package:cancerrapp/Helper/Database/BaseDatabase.dart';
import 'package:cancerrapp/Models/DoctorModel.dart';

import '../Helper/Components/Table.dart';

class DoctorRepository {
  static final dao =
      BaseRepository<DoctorModel>(DoctorModel(), tableName: Table.doctors);
  Future<DoctorModel> find(int id) => dao.find(id);
  Future<List<DoctorModel>> getAll() => dao.getAll();
  Future<int> insert(DoctorModel reminder) => dao.insert(reminder);
  Future<void> update(DoctorModel reminder) => dao.update(reminder);
  Future<void> delete(DoctorModel reminder) => dao.delete(reminder);
  Future<void> deleteById(int id) => dao.deleteById(id);
}
