import 'package:flutter/material.dart';
import '../control/okayProceedButtonFun.dart';
import 'eyeShape.dart';

Widget okayProceedButton({required BuildContext context}) {
  return InkWell(
    onTap: () => okayProceedButtonFun(context: context),
    child: EyeShape(
      backGround: Colors.green,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 14,
        child: const Center(child: Text('Okay, proceed!')),
      ),
    ),
  );
}
