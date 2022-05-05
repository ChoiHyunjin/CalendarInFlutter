import 'package:calendar/src/models/schedule.dart';
import 'package:calendar/src/routes/add_schedule/widgets/inputs/content_input.dart';
import 'package:calendar/src/routes/add_schedule/widgets/inputs/date_input.dart';
import 'package:calendar/src/routes/add_schedule/widgets/inputs/title_input.dart';
import 'package:calendar/src/routes/add_schedule/widgets/inputs/user_picker.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:flutter/material.dart';

enum _Times { NONE, START, END }

class AddScheduleRoute extends StatefulWidget {
  final Function() onRegister;
  const AddScheduleRoute({Key? key, required this.onRegister}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddScheduleRouteState();
  }
}

class _AddScheduleRouteState extends State<AddScheduleRoute> {
  var _selectedTimeIndex = _Times.NONE;
  late Schedule schedule = Schedule();

  _AddScheduleRouteState() {}

  void _onForcePressEnd(TapUpDetails details) {
    if (schedule.id >= 0) {
      Preference.shared.update(schedule);
    } else {
      Preference.shared.insert(schedule);
    }

    if (schedule.people != '') {
      var newSchedule = schedule.clone(schedule.id);
      newSchedule.people = Preference.shared.id;
      newSchedule.userId = schedule.people;
      Preference.shared.insert(newSchedule);
    }
    widget.onRegister();
    Navigator.pop(context);
  }

  void _onChangeTitle(String text) {
    schedule.title = text;
  }

  void _onChangeContent(String text) {
    schedule.content = text;
  }

  void _onStartDaySelected(DateTime time) {
    setState(() {
      schedule.startDate = time;
      if(time.isAfter(schedule.endDate)){
        schedule.endDate = time;
      }
    });
  }

  void _onEndDaySelected(DateTime time) {
    schedule.endDate = time;
  }

  void onDateTap(_Times at) {
    setState(() {
      if (_selectedTimeIndex == at) {
        _selectedTimeIndex = _Times.NONE;
      } else {
        _selectedTimeIndex = at;
      }
    });
  }

  void onSelectPeople(String user) {
    schedule.people = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("일정"),
        actions: [
          GestureDetector(
            child: const Padding(
              child: Text("저장", style: TextStyle(fontSize: 16)),
              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
            ),
            onTapUp: _onForcePressEnd,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          TitleInput(
            onChangeText: _onChangeTitle,
          ),
          const Divider(height: 1, color: Colors.black26),
          ContentInput(
            onChangeText: _onChangeContent,
          ),
          const Divider(height: 1, color: Colors.black26),
          DateInput(
              title: '시작',
              onDaySelected: _onStartDaySelected,
              onDateTap: () => onDateTap(_Times.START),
              selected: _selectedTimeIndex == _Times.START),
          const Divider(height: 1, color: Colors.black26),
          DateInput(
              title: '종료',
              onDaySelected: _onEndDaySelected,
              startTime: schedule.startDate,
              onDateTap: () => onDateTap(_Times.END),
              selected: _selectedTimeIndex == _Times.END),
          const Divider(height: 1, color: Colors.black26),
          UserPicker(onSelect: onSelectPeople)
        ],
      ),
    );
  }
}
