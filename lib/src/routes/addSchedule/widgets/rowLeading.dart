import 'package:flutter/material.dart';

class AddScheduleTableRowLeading extends StatelessWidget {
  final Widget? child;

  const AddScheduleTableRowLeading({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 60,
      alignment: Alignment.center,
      child: child,
    );
  }
}
