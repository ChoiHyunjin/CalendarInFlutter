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
      _startDate = startDate;
    }
    if (endDate != null) {
      _endDate = endDate;
    }
    _title = title;
    _people = people;
  }

  clone() => Schedule(
      id: _id,
      title: _title,
      content: _content,
      startDate: _startDate,
      people: _people);

  final _id = -1;
  String userId = Preference().id;
  var _title = '';
  var _content = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  var _people = '';

  get id {
    return _id;
  }

  get title {
    return _title;
  }

  get content {
    return _content;
  }

  get startDate {
    return _startDate;
  }

  get endDate {
    return _endDate;
  }

  get people {
    return _people;
  }

  void updateFrom(Schedule newOne) {
    _title = newOne.title;
    _content = newOne.content;
    _startDate = newOne.startDate;
    _endDate = newOne.endDate;
    _people = newOne.people;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': _title,
      'content': _content,
      'startYear': _startDate.year,
      'startMonth': _startDate.month,
      'startDay': _startDate.day,
      'startHour': _startDate.hour,
      'startMinute': _startDate.minute,
      'endYear': _endDate.year,
      'endMonth': _endDate.month,
      'endDay': _endDate.day,
      'endHour': _endDate.hour,
      'endMinute': _endDate.minute,
      'people': _people,
    };
  }
}
