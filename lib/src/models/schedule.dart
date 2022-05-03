import 'package:calendar/src/utils/preference.dart';

class Schedule {
  static Schedule from(Map<String, dynamic> input) {
    return Schedule(
        id: input['id'],
        title: input['title'],
        content: input['content'],
        startDate: DateTime(input['startYear'], input['startMonth'],
            input['startDay'], input['startHour'], input['startMinute']),
        endDate: DateTime(input['endYear'], input['endMonth'], input['endDay'],
            input['endHour'], input['endMinute']),
        people: input['people']);
  }

  static int mergeDate(int year, int month, int day){
    var res = year.toString();
    if(month.toString().length < 2){
      res += '0';
    }
    res += month.toString();
    if(day.toString().length < 2){
      res += '0';
    }
    res += day.toString();
    return int.parse(res);
  }

  Schedule(
      {id = 0,
      title = '',
      content = '',
      DateTime? startDate,
      DateTime? endDate,
      people = ''}) {
    if (startDate != null) {
      startDate = startDate;
    }
    if (endDate != null) {
      endDate = endDate;
    }
    title = title;
    people = people;
  }

  Schedule clone(int id) {
    return Schedule(
        id: id,
        title: title,
        content: content,
        startDate: startDate,
        endDate: endDate,
        people: people);
  }

  final _id = -1;
  String userId = Preference().id;
  var title = '';
  var content = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var people = '';

  get id {
    return _id;
  }

  void updateFrom(Schedule newOne) {
    title = newOne.title;
    content = newOne.content;
    startDate = newOne.startDate;
    endDate = newOne.endDate;
    people = newOne.people;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'startDate': Schedule.mergeDate(startDate.year, startDate.month, startDate.day),
      'startHour': startDate.hour,
      'startMinute': startDate.minute,
      'endDate': Schedule.mergeDate(endDate.year, endDate.month, endDate.day),
      'endHour': endDate.hour,
      'endMinute': endDate.minute,
      'people': people,
    };
  }
}
