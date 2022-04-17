import 'package:calendar/src/routes/add_schedule/widgets/date_picker.dart';
import 'package:calendar/src/routes/add_schedule/widgets/row_leading.dart';
import 'package:calendar/src/utils/string_formatter.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  const DateInput({Key? key}) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  var _index = -1;
  var _time = DateTime.now();
  final days = ['월', '화', '수', '목', '금', '토', '일'];

  void onDaySelected(DateTime time) {
    setState(() {
      _time = DateTime.utc(
          time.year, time.month, time.day, _time.hour, _time.minute);
      _index = 1;
    });
  }

  void onTimeSelected(TimeOfDay? time) {
    if (time == null) {
      return;
    }
    setState(() {
      _time = DateTime.utc(
          _time.year, _time.month, _time.day, time.hour, time.minute);
      _index = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AddScheduleTableRowLeading(
          child: Icon(Icons.schedule, color: Colors.black26, size: 24),
        ),
        Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTapUp: (TapUpDetails detail) {
                          setState(() {
                            _index = _index == 0 ? -1 : 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                          child: Text(
                              '${_time.month.toString()}월 ${_time.day.toString()}일 ${days[_time.weekday - 1]}요일',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      child: GestureDetector(
                        child: Text(
                            '${_time.hour.toString()}:${StringFormatter.getFormattedTime(_time.minute)}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        onTapUp: (TapUpDetails detail) {
                          Future<TimeOfDay?> onSelected = showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_time));
                          onSelected.then(onTimeSelected);
                        },
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    )
                  ],
                ),
                if (_index == 0)
                  DatePicker(onDaySelected: onDaySelected, date: _time)
              ],
            ),
            flex: 1),
      ],
    );
  }
}
