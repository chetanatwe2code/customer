import 'package:flutter/material.dart';

class SmallDot extends StatelessWidget {
  final Color? color;

  const SmallDot({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color ?? Colors.blueGrey.withOpacity(0.3),
      ),
    );
  }
}
