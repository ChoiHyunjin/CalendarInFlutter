import 'package:calendar/src/models/schedule.dart';
import 'package:calendar/src/routes/schedule_list/schedule_list.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final _CalendarState _state = _CalendarState();

  Calendar({Key? key}) : super(key: key);

  void getSchedules() {
    _state.getSchedules(_state._focusedDay);
  }

  @override
  _CalendarState createState() => _state;
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<String, List<Schedule>>? scheduleMap;

  _CalendarState() {
    getSchedules(_focusedDay);
  }

  void getSchedules(DateTime date) {
    debugPrint('date: $date');
    Preference.shared.loadOn(date.year, date.month).then((value) {
          setState(() {
            scheduleMap = getMapFromList(value);
            _focusedDay = date;
          });
        });
  }

  Map<String, List<Schedule>> getMapFromList(List<Schedule> schedules) {
    var map = <String, List<Schedule>>{};

    for (var element in schedules) {
      var start = DateTime(element.startDate.year, element.startDate.month,
          element.startDate.day);
      while (!start.isAfter(element.endDate)) {
        if (!map.containsKey(start.day.toString())) {
          map[start.day.toString()] = [];
        }
        map[start.day.toString()]?.add(element);
        // fixme DateTime.add() 미동작으로 객체 생성 방식 적용
        start = DateTime(
            element.startDate.year, element.startDate.month, start.day + 1);
      }
    }

    debugPrint('map: $map');
    return map;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('scheduleMap: ${scheduleMap?.keys}');
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        Route listRoute = MaterialPageRoute(
            builder: (context) => ScheduleListRoute(date: selectedDay));
        Navigator.push(context, listRoute);
      },
      shouldFillViewport: true,
      onPageChanged: getSchedules,
      calendarBuilders: CalendarBuilders(markerBuilder: (context, day, list) {
        if (scheduleMap?.containsKey(day.day.toString()) == true &&
            _focusedDay.month == day.month) {
          return Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(8))),
          );
        }
      }),
    );
  }
}
