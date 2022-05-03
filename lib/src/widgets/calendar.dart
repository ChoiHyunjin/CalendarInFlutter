import 'package:calendar/src/models/schedule.dart';
import 'package:calendar/src/routes/schedule_list/schedule_list.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  _CalendarState() {
    getSchedules(_focusedDay);
  }

  void getSchedules(DateTime date) {
    Preference.shared.loadOn(date.year, date.month);
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
