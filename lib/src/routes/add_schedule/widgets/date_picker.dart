import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const pageDuration = 300;

class DatePicker extends StatelessWidget {
  PageController? _pageController;
  final Function(DateTime selected)? onDaySelected;
  final DateTime date;
  late final DateTime? start;

  DatePicker({Key? key, this.onDaySelected, required this.date, this.start})
      : super(key: key) {
    debugPrint('DatePicker construct');
    start ??= DateTime.utc(2010, 10, 16);
  }

  @override
  Widget build(BuildContext context) {
    var focused = date.isAfter(start!) ? date : start!;
    return Column(
      children: [
        _CalendarHeader(
          focusedDay: focused,
          onLeftArrowTap: () {
            _pageController!.previousPage(
              duration: const Duration(milliseconds: pageDuration),
              curve: Curves.easeOut,
            );
          },
          onRightArrowTap: () {
            _pageController!.nextPage(
              duration: const Duration(milliseconds: pageDuration),
              curve: Curves.easeOut,
            );
          },
        ),
        Container(
          child: TableCalendar(
            firstDay: start!,
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focused,
            selectedDayPredicate: (selected) {
              return isSameDay(date, selected);
            },
            onCalendarCreated: (controller) => _pageController = controller,
            headerVisible: false,
            onDaySelected: (selectedDay, focusedDay) {
              if (onDaySelected != null) {
                onDaySelected!(selectedDay);
              }
            },
            shouldFillViewport: true,
          ),
          height: 250,
          padding: const EdgeInsets.all(20),
        )
      ],
    );
  }
}

class _CalendarHeader extends StatefulWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarHeaderState();
  }
}

class _CalendarHeaderState extends State<_CalendarHeader> {
  late DateTime _focus;
  late DateTime _min;

  @override
  void initState() {
    super.initState();
    _focus = DateTime(widget.focusedDay.year, widget.focusedDay.month);
    _min = DateTime(widget.focusedDay.year, widget.focusedDay.month);
  }

  @override
  void didUpdateWidget(_CalendarHeader old) {
    if (widget.focusedDay != old.focusedDay) {
      setState(() {
        _focus = DateTime(widget.focusedDay.year, widget.focusedDay.month);
        _min = DateTime(widget.focusedDay.year, widget.focusedDay.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16.0),
        SizedBox(
          width: 120.0,
          child: Text(
            _focus.month.toString() + '월',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if (_min.isAfter(_focus) || _min.month == _focus.month) return;
            setState(() {
              _focus = DateTime(
                  _focus.month == 1 ? _focus.year - 1 : _focus.year,
                  _focus.month == 1 ? 12 : _focus.month - 1);
            });
            widget.onLeftArrowTap();
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _focus = DateTime(
                  _focus.month == 12 ? _focus.year + 1 : _focus.year,
                  _focus.month == 12 ? 1 : _focus.month + 1);
            });
            widget.onRightArrowTap();
          },
        ),
      ],
    );
  }
}
