import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const pageDuration = 300;

class DatePicker extends StatelessWidget {
  PageController? _pageController;
  final Function(DateTime selected)? onDaySelected;
  final DateTime date;

  DatePicker({Key? key, this.onDaySelected, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CalendarHeader(
          focusedDay: date,
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
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: date,
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
  var _month = 0;

  @override
  void initState() {
    super.initState();
    _month = widget.focusedDay.month;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16.0),
        SizedBox(
          width: 120.0,
          child: Text(
            _month.toString() + '월',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _month--;
            });
            widget.onLeftArrowTap();
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _month++;
            });
            widget.onRightArrowTap();
          },
        ),
      ],
    );
  }
}
