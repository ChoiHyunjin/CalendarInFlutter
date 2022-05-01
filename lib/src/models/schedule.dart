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
      'startYear': startDate.year,
      'startMonth': startDate.month,
      'startDay': startDate.day,
      'startHour': startDate.hour,
      'startMinute': startDate.minute,
      'endYear': endDate.year,
      'endMonth': endDate.month,
      'endDay': endDate.day,
      'endHour': endDate.hour,
      'endMinute': endDate.minute,
      'people': people,
    };
  }
}
