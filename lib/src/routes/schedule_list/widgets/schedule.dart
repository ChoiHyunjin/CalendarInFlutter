import 'package:calendar/src/models/schedule.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  Schedule schedule;

  ScheduleWidget({Key? key, required this.schedule}) : super(key: key);

  String getDateFrom(DateTime date) {
    var res = date.year.toString();
    const separator = '/';
    debugPrint('schedule: ${schedule.toMap()}');
    res += separator + date.month.toString() + separator + date.day.toString();
    res += ' ' + date.hour.toString() + ':' + date.minute.toString();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.red,
          width: 5.0,
          height: 40.0,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Text(
              schedule.title == '' ? '제목 없음' : schedule.title,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Column(
          children: [
            Text(getDateFrom(schedule.startDate)),
            Text(getDateFrom(schedule.endDate)),
            if (schedule.people.isNotEmpty)
              Text(
                '일행: ${schedule.people}',
                style: TextStyle(color: Colors.black54),
              )
          ],
        )
      ],
    );
  }
}
