import 'package:calendar/src/models/schedule.dart';
import 'package:calendar/src/routes/schedule_list/widgets/schedule.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:flutter/material.dart';

class ScheduleListRoute extends StatefulWidget {
  const ScheduleListRoute({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  _ScheduleListRouteState createState() => _ScheduleListRouteState();
}

class _ScheduleListRouteState extends State<ScheduleListRoute> {
  List<Schedule> data = [];

  @override
  void initState() {
    super.initState();
    final date = Schedule.mergeDate(
        widget.date.year, widget.date.month, widget.date.day);
    Preference.shared.loadAt(date).then((value) => {
          setState(() {
            data = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.date.year.toString() +
              '년 ' +
              widget.date.month.toString() +
              '월 ' +
              widget.date.day.toString() +
              '일')),
      body: ListView.builder(
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ScheduleWidget(schedule: data[index], index: index),
            );
          }),
          itemCount: data.length,
          padding: EdgeInsets.all(20)),
    );
  }
}
