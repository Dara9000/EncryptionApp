import 'package:encr/control/pickAFileFun.dart';
import 'package:flutter/material.dart';
import 'eyeButton.dart';

Widget PickAFileButton(BuildContext context) {
  double width = MediaQuery.of(context).size.width / 2;
  double height = MediaQuery.of(context).size.height / 3;

  return InkWell(
    onTap: () => pickAFileFun(context),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ListTile(
        subtitle: const FittedBox(
          fit: BoxFit.cover,
          child: Text(
            'Pick a File',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
        title: EyeButton(
          color: Colors.green,
          height: height,
          width: width,
          child: const Icon(
            Icons.file_open_outlined,
            color: Colors.green,
          ),
        ),
      ),
    ),
  );
}
