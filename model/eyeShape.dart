import 'package:flutter/material.dart';

class EyeShape extends StatelessWidget {
  Widget child;
  Color backGround;
  Color borderColor;
  double borderWidth;
  EyeShape(
      {super.key,
      required this.child,
      this.backGround = Colors.transparent,
      this.borderColor = Colors.green,
      this.borderWidth = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backGround,
          border: Border.all(width: borderWidth, color: borderColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(0),
          )),
      child: child,
    );
  }
}
