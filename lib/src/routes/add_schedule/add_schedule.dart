import 'package:calendar/src/routes/add_schedule/widgets/inputs/content_input.dart';
import 'package:calendar/src/routes/add_schedule/widgets/inputs/date_input.dart';
import 'package:calendar/src/routes/add_schedule/widgets/inputs/title_input.dart';
import 'package:flutter/material.dart';

enum _Times { NONE, START, END }

class AddScheduleRoute extends StatefulWidget {
  const AddScheduleRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddScheduleRouteState();
  }
}

class _AddScheduleRouteState extends State<AddScheduleRoute> {
  var _title = '';
  var _content = '';
  DateTime? _start;
  DateTime? _end;
  var _selectedTimeIndex = _Times.NONE;

  void _onForcePressEnd(TapUpDetails details) {
    Navigator.pop(context);
    debugPrint("_onForcePressEnd");
  }

  void _onChangeTitle(String text) {
    debugPrint('text: $text');
    _title = text;
  }

  void _onChangeContent(String text) {
    debugPrint('text: $text');
    _content = text;
  }

  void _onStartDaySelected(DateTime time) {
    setState(() {
      _start = time;
    });
  }

  void _onEndDaySelected(DateTime time) {
    _end = time;
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

  @override
  Widget build(BuildContext context) {
    debugPrint(DateTime.utc(2010, 10, 16).toString());
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
              startTime: _start,
              onDateTap: () => onDateTap(_Times.END),
              selected: _selectedTimeIndex == _Times.END),
        ],
      ),
    );
  }
}
