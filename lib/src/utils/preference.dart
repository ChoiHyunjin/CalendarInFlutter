import 'package:calendar/src/models/schedule.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Preference {
  static Preference shared = Preference._internal();

  factory Preference() {
    return shared;
  }

  late final Database db;
  late final String id;

  Preference._internal() {
    getDatabasesPath().then((res) async {
      db = await openDatabase(join(await getDatabasesPath(), 'schedules.db'),
          onCreate: (db, version) {
            return db.execute(
                "CREATE TABLE schedules(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, userId TEXT, title TEXT, content TEXT, startYear INTEGER, startMonth INTEGER, startDay INTEGER, startHour INTEGER, startMinute INTEGER, endYear INTEGER, endMonth INTEGER, endDay INTEGER, endHour INTEGER, endMinute INTEGER, people TEXT)");
          }, version: 1);
    });
  }

  void setId(String id) {
    this.id = id;
  }

  Future<int> save(Schedule schedule) {
    return db.insert('schedule', schedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Schedule>> load() async {
    final List<Map<String, dynamic>> maps = await db.query('schedules');
    return List.generate(maps.length, (index) => Schedule.from(maps[index]));
  }

  Future<void> insert(Schedule schedule) async {
    await db.insert('schedules', schedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Schedule schedule) async {
    await db.update('schedules', schedule.toMap(), where: "id = ?",
        whereArgs: [schedule.id]);
  }

  void reset(){
    Preference.shared = Preference._internal();
  }
}
