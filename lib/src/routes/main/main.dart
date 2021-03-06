import 'package:calendar/src/routes/add_schedule/add_schedule.dart';
import 'package:calendar/src/routes/login/login.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:calendar/src/widgets/calendar.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final Calendar _calendar = Calendar();

  _HomeRouteState() {
    Preference.shared.load();
  }

  void onRegister() {
    _calendar.getSchedules();
  }

  void _addSchedule(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddScheduleRoute(onRegister: onRegister)));
  }

  void onTapUp(TapUpDetails details) {
    logout();
  }

  void logout() {
    Route home = MaterialPageRoute(
        builder: (context) => LoginRoute(title: widget.title));
    Navigator.pushReplacement(context, home);
    Preference.shared.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            child: GestureDetector(
              child: Text('๋ก๊ทธ์์'),
              onTapUp: onTapUp,
            ),
            padding: EdgeInsets.fromLTRB(0, 20, 10, 10),
          )
        ],
      ),
      body: Container(
        child: _calendar,
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
