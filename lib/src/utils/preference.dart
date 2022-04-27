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
      db = await openDatabase(join(res, 'schedules.db'));
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
    final List<Map<String, dynamic>> maps = await db.query('schedule');
    return maps.map((e) => Schedule.from(e));
  }
}
