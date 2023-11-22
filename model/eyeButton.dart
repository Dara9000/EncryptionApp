// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EyeButton extends StatelessWidget {
  Widget? child;
  Color color;
  double? width;
  double? height;
  EyeButton({
    super.key,
    required this.child,
    required this.color,
    required this.width,
    required this.height,
  });
  @override
  Widget build(BuildContext context) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(75),
          bottomLeft: Radius.circular(75),
          bottomRight: Radius.circular(0),
        ),
        border: Border.all(
          color: color,
          width: 20,
        ),
        gradient: const LinearGradient(
            begin: Alignment(6.123234262925839e-17, 1),
            end: Alignment(-1, 6.123234262925839e-17),
            colors: [
              Colors.transparent,
              Colors.transparent,
            ]),
      ),
      child: FittedBox(fit: BoxFit.contain, child: child));
}
