import 'package:calendar/src/models/schedule.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Preference {
  static final Preference shared = Preference._internal();

  factory Preference() {
    return Preference.shared;
  }

  late final Database db;
  late final String id;

  Preference._internal() {
    getDatabasesPath().then((res) async {
      db = await openDatabase(join(res, 'schedules.db'),
          onCreate: (db, version) {
            return db.execute(
                "CREATE TABLE schedules(id INTEGER PRIMARY KEY, userId TEXT, title TEXT, content TEXT, startYear INTEGER, startMonth INTEGER, startHour INTEGER, startMinute INTEGER, endYear INTEGER, endMonth INTEGER, endHour INTEGER, endMinute INTEGER, people TEXT)");
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
    db.insert('schedules', schedule.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Schedule schedule) async {
    db.update('schedules', schedule.toMap(), where: "id = ?", whereArgs: [schedule.id]);
  }
}