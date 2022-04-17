
import 'package:calendar/src/routes/add_schedule/widgets/row_leading.dart';
import 'package:flutter/material.dart';

class ContentInput extends StatefulWidget {
  final Function(String text)? onChangeText;

  const ContentInput({Key? key, this.onChangeText}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ContentInput> {
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
        const AddScheduleTableRowLeading(
          child: Icon(Icons.subject, color: Colors.black26, size: 24),
        ),
        Expanded(
          child: Container(
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '내용 추가',
              ),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(fontSize: 16),
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
