class Schedule {
  Schedule({title = '', content = '', DateTime? date, people = ''}) {
    if (date != null) {
      _date = date;
    }
    _title = title;
    _people = people;
  }

  clone() =>
      Schedule(title: _title, content: _content, date: _date, people: _people);

  var _title = '';
  var _content = '';
  DateTime _date = DateTime.now();
  var _people = '';

  get title {
    return _title;
  }

  get content {
    return _content;
  }

  get date {
    return _date;
  }

  get time {
    return _date.hour;
  }

  get minute {
    return _date.minute;
  }

  get people {
    return _people;
  }

  void updateFrom(Schedule newOne) {
    _title = newOne.title;
    _content = newOne.content;
    _date = newOne.date;
    _people = newOne.people;
  }
}
