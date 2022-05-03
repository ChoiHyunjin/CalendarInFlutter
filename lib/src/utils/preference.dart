import 'package:calendar/src/models/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const scheduleTable = 'schedules';

class Preference {
  static Preference shared = Preference._internal();

  factory Preference() {
    return shared;
  }

  late final Database db;
  late final String id;

  Preference._internal() {
    getDatabasesPath().then((res) async {
      db = await openDatabase(
          join(await getDatabasesPath(), scheduleTable, '.db'),
          onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE schedules(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, userId TEXT, title TEXT, content TEXT, startDate INTEGER, startHour INTEGER, startMinute INTEGER, endDate INTEGER, endHour INTEGER, endMinute INTEGER, people TEXT)");
      }, version: 1);
    });
  }

  void setId(String id) {
    this.id = id;
  }

  Future<int> save(Schedule schedule) {
    return db.insert(scheduleTable, schedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Schedule>> load() async {
    final List<Map<String, dynamic>> maps =
        await db.query(scheduleTable, where: "userId = ?", whereArgs: [id]);
    debugPrint('load: $id, $maps');
    return List.generate(maps.length, (index) => Schedule.from(maps[index]));
  }

  Future<List<Schedule>> loadAt(int date) async {
    final List<Map<String, dynamic>> maps = await db.query(scheduleTable,
        where: "userId = ? AND startDate <= ? AND endDate >= ?",
        whereArgs: [id, date, date]);
    debugPrint('loadAt: $id, $maps');
    return List.generate(maps.length, (index) => Schedule.from(maps[index]));
  }

  Future<List<Schedule>> loadOn(int year, int month) async {
    final first = DateTime.utc(year, month);
    final last =
        DateTime.utc(year, month + 1).subtract(const Duration(days: 1));
    final firstDate = Schedule.mergeDate(first.year, first.month, first.day);
    final lastDate = Schedule.mergeDate(last.year, last.month, last.day);
    debugPrint('loadOn input: $firstDate, $lastDate');
    final List<Map<String, dynamic>> maps = await db.query(scheduleTable,
        where:
            "userId = ? AND ((startDate >= ? AND startDate <= ?) OR (endDate >= ? AND endDate <= ?))",
        whereArgs: [id, firstDate, lastDate, firstDate, lastDate]);
    debugPrint('loadOn: $id, $maps');
    return List.generate(maps.length, (index) => Schedule.from(maps[index]));
  }

  Future<void> insert(Schedule schedule) async {
    await db.insert(scheduleTable, schedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Schedule schedule) async {
    await db.update(scheduleTable, schedule.toMap(),
        where: "id = ?", whereArgs: [schedule.id]);
  }

  void reset() {
    Preference.shared = Preference._internal();
  }
}
