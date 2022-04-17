import 'package:calendar/src/routes/addSchedule/widgets/inputs/contentInput.dart';
import 'package:calendar/src/routes/addSchedule/widgets/inputs/titleInput.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
