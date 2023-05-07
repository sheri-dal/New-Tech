// class ReminderRepository {
//   final dao = Dao<Reminder>(Reminder(), tableName: REMINDER_DB_TABLE);
//   Future<Reminder> find(int id) => dao.find(id);
//   Future<List<Reminder>> getAll() => dao.getAll();
//   Future<int> insert(Reminder reminder) => dao.insert(reminder);
//   Future<void> update(Reminder reminder) => dao.update(reminder);
//   Future<void> delete(Reminder reminder) => dao.delete(reminder);
//   Future<void> deleteById(int id) => dao.deleteById(id);
// }

import 'package:cancerrapp/Helper/Components/ImagesPath.dart';
import 'package:cancerrapp/Helper/Helper.dart';
import 'package:cancerrapp/Models/DoctorModel.dart';
import 'package:cancerrapp/Models/UserModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Components/Table.dart';

class DatabaseHelper {
  static const idtype = 'INTEGER PRIMARY KEY';
  static const textNotNullType = 'TEXT NOT NULL';
  static const interType = 'INTEGER';
  static const textType = 'Text';
  int version = 1;
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // _database = await _initDB();
    // return _database!;
    // if (_database == null) {
    if (_database == null) {
      _database = await _initDB();
    }
    // }
    return _database!;
  }

  Future<Database> _initDB() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, 'CancerApp.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database db, version) async {
    await db.execute('''
          CREATE TABLE ${Table.users} (
            id INTEGER PRIMARY KEY,
            userName TEXT NOT NULL,
            password TEXT NOT NULL,
            firstName TEXT,
            lastName TEXT,
            email TEXT)''');
    await db.insert(
        Table.users,
        UserModel(userName: "sheri", password: Helper.PasswordHash("123"))
            .toMap());
    await db.execute('''
          CREATE TABLE ${Table.doctors} (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            mobileNumber TEXT,
            hospitalName TEXT,
            specilist TEXT,
            doctorTiming TEXT,
            doctorDay TEXT,
            imagePath TEXT,
            city TEXT
            )''');
    db.insert(
        Table.doctors,
        DoctorModel(
                name: "Muhammad Ashar Khan",
                mobileNumber: "92-335-2774491",
                hospitalName: "Agha Khan",
                doctorDay: "Mon-Tue-Sat",
                doctorTiming: "9AM - 12PM",
                specilist: "Skin Specialist",
                imagePath: "${AppImages.DrAshar}",
                city: "Karachi")
            .toMap());
    db.insert(
        Table.doctors,
        DoctorModel(
                name: "Syed Ashar Kalam",
                mobileNumber: "92-306-2207478",
                hospitalName: "Agha Khan",
                doctorDay: "Mon-Tue-Fri",
                doctorTiming: "3PM - 6PM",
                specilist: "Skin Specialist",
                imagePath: "${AppImages.DrAsharkalam}",
                city: "Karachi")
            .toMap());
    db.insert(
        Table.doctors,
        DoctorModel(
                name: "M.Anus Farrukh",
                mobileNumber: "92-332-2055374",
                hospitalName: "Agha Khan",
                doctorDay: "Wed-Fri-Sat",
                doctorTiming: "6PM - 9PM",
                specilist: "Skin Specialist",
                imagePath: "${AppImages.DrAnus}",
                city: "Karachi")
            .toMap());
    db.insert(
        Table.doctors,
        DoctorModel(
                name: "Obaid Ur-Rehman",
                mobileNumber: "92-304-2518363",
                hospitalName: "Agha Khan",
                doctorDay: "Mon-Tue-Sat",
                doctorTiming: "9AM - 12PM",
                specilist: "Skin Specialist",
                imagePath: "${AppImages.DrObaid}",
                city: "Karachi")
            .toMap());

    await db.execute('''
          CREATE TABLE ${Table.reposrt} (
            id INTEGER PRIMARY KEY,
            userId $interType,
            reportDateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
            cancerStage TEXT,
            imagePath TEXT,
            FOREIGN KEY (userId) REFERENCES ${Table.users}(id)
            )''');
    await db.rawInsert(
        "INSERT INTO ${Table.reposrt} (userId, cancerStage)VALUES (1, 'not found');");
    await db.rawInsert(
        "INSERT INTO ${Table.reposrt} (userId, cancerStage)VALUES (1, 'not found');");
    await db.execute('''
          CREATE TABLE ${Table.appoinment} (
            id INTEGER PRIMARY KEY,
            userId $interType,
            doctorId $interType,
            date DATETIME,
            FOREIGN KEY (userId) REFERENCES ${Table.users}(id),
            FOREIGN KEY (userId) REFERENCES ${Table.doctors}(id)
            )''');
    await db.rawInsert(
        "INSERT INTO ${Table.appoinment} (userId, doctorId)VALUES (1, 1);");
  }

  onUpgrade(Database db, oldVersion, newVersion) async {}
}
