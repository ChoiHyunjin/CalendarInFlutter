import 'package:calendar/src/routes/add_schedule/widgets/date_picker.dart';
import 'package:calendar/src/routes/add_schedule/widgets/row_leading.dart';
import 'package:calendar/src/utils/string_formatter.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  const DateInput(
      {Key? key,
      required this.title,
      required this.onDaySelected,
      required this.onDateTap,
      required this.selected,
      this.startTime})
      : super(key: key);
  final String title;
  final Function(DateTime time) onDaySelected;
  final Function() onDateTap;
  final DateTime? startTime;
  final bool selected;

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  var _index = -1;
  var _time = DateTime.now();
  final days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  @protected
  void didUpdateWidget(DateInput oldWidget) {
    super.didUpdateWidget(widget);
    if (widget.startTime != oldWidget.startTime) {
      setState(() {
        if(widget.startTime != null && widget.startTime!.isAfter(_time)){
          _time = widget.startTime!;
        }
      });
    }
  }

  void onDaySelected(DateTime time) {
    setState(() {
      _time = DateTime.utc(
          time.year, time.month, time.day, _time.hour, _time.minute);
      _index = 1;
    });
    widget.onDaySelected(_time);
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
    widget.onDaySelected(_time);
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
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTapUp: (TapUpDetails detail) {
                          widget.onDateTap();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 22, 0, 22),
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
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    )
                  ],
                ),
                if (widget.selected)
                  DatePicker(
                    onDaySelected: onDaySelected,
                    date: _time,
                    start: widget.startTime ?? DateTime.utc(2010, 10, 16),
                  )
              ],
            ),
            flex: 1),
      ],
    );
  }
}
