import 'package:flutter/material.dart';

class TitledTitleInput extends StatelessWidget {
  const TitledTitleInput(
      {Key? key,
      required this.title,
      required this.onChangeText,
      this.hintText,
      this.obscureText})
      : super(key: key);
  final String title;
  final Function(String text) onChangeText;
  final String? hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(title,
              style: const TextStyle(fontSize: 16, color: Colors.black45),
              textAlign: TextAlign.left),
          alignment: Alignment.centerLeft,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextFormField(
            onChanged: onChangeText,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: hintText,
            ),
            obscureText: obscureText ?? false,
          ),
        )
      ],
    );
  }
}
