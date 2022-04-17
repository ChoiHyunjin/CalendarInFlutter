// todo 수정 기능
import 'package:calendar/src/routes/addSchedule/widgets/rowLeading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleInput extends StatefulWidget {
  final Function(String text)? onChangeText;

  const TitleInput({Key? key, this.onChangeText}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<TitleInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChangeText!(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AddScheduleTableRowLeading(),
        Expanded(
          child: Container(
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '제목 추가',
              ),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(fontSize: 20),
            ),
            height: 60,
            alignment: Alignment.center,
          ),
          flex: 1,
        )
      ],
    );
  }
}
