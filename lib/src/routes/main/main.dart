import 'package:calendar/src/routes/add_schedule/add_schedule.dart';
import 'package:calendar/src/widgets/calendar.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  void _addSchedule(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddScheduleRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: const Calendar(),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 60),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSchedule(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
