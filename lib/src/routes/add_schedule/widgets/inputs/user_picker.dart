import 'package:calendar/src/routes/add_schedule/widgets/row_leading.dart';
import 'package:calendar/src/utils/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const users = ['user1', 'user2'];

class UserPicker extends StatefulWidget {
  final Function(String user) onSelect;

  const UserPicker({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserPickerState();
  }
}

class _UserPickerState extends State<UserPicker> {
  List<String> user = [...users];
  var visible = false;

  _UserPickerState() {
    user.remove(Preference.shared.id);
  }

  void onSelectedItemChanged(int index) {
    widget.onSelect(user[index]);
  }

  void onTapUp(TapUpDetails details) {
    widget.onSelect(visible ? '': user[0] );
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const AddScheduleTableRowLeading(
            child: Icon(Icons.person, color: Colors.black26, size: 24),
          ),
          GestureDetector(
            onTapUp: onTapUp,
            child: Padding(
              child: Text(
                '공유 유저',
                style: const TextStyle(fontSize: 20),
              ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            ),
          ),
        ]),
        if (visible)
          Padding(
              child: Container(
                width: 200,
                height: 100,
                child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: onSelectedItemChanged,
                    children: [...user.map((e) => Text(e))]),
              ),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
        const Divider(height: 1, color: Colors.black26),
      ],
    );
  }
}
