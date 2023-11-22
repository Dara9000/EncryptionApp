import 'package:flutter/material.dart';

class SimpleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SimpleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  _SimpleSwitchState createState() => _SimpleSwitchState();
}

class _SimpleSwitchState extends State<SimpleSwitch> {
  late bool turnState;

  @override
  void initState() {
    super.initState();
    turnState = widget.value;
  }

  void toggleSwitch() {
    setState(() {
      turnState = !turnState;
      widget.onChanged(turnState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: Container(
        width: MediaQuery.of(context).size.width / 6,
        decoration: BoxDecoration(
          color: turnState ? Colors.transparent : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: turnState
              ? const Icon(Icons.dark_mode_outlined, color: Colors.green)
              : const Icon(Icons.light_mode_outlined, color: Colors.green),
        ),
      ),
    );
  }
}
